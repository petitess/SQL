USE DotNetCourseDatabase;
GO

ALTER PROCEDURE TutorialAppSchema.spUsers_Get 
/*EXEC TutorialAppSchema.spUsers_Get @UserId=3*/
--Parameter
    @UserId INT = NULL
AS 
BEGIN
    SELECT [Users].[UserId],
    [Users].[FirstName],
    [Users].[LastName],
    [Users].[Email],
    [Users].[Gender],
    [Users].[Active] 
    From TutorialAppSchema.Users AS Users
        WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
END
------
USE DotNetCourseDatabase;
GO

ALTER PROCEDURE TutorialAppSchema.spUsers_Get 
/*EXEC TutorialAppSchema.spUsers_Get @UserId=3*/
--Parameter
    @UserId INT = NULL
AS 
BEGIN
    SELECT [Users].[UserId],
    [Users].[FirstName],
    [Users].[LastName],
    [Users].[Email],
    [Users].[Gender],
    [Users].[Active],
    UserSalary.Salary,
    UserJobInfo.JobTitle,
    UserJobInfo.Department
    From TutorialAppSchema.Users AS Users
        LEFT JOIN TutorialAppSchema.UserSalary AS UserSalary
            ON UserSalary.UserId = Users.UserId
        LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
            ON UserJobInfo.UserId = Users.UserId
        WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
END
-------
USE DotNetCourseDatabase;
GO

ALTER PROCEDURE TutorialAppSchema.spUsers_Get
    /*EXEC TutorialAppSchema.spUsers_Get @UserId=3*/
    --Parameter
    @UserId INT = NULL
AS 
BEGIN
    SELECT [Users].[UserId],
        [Users].[FirstName],
        [Users].[LastName],
        [Users].[Email],
        [Users].[Gender],
        [Users].[Active],
        UserSalary.Salary,
        UserJobInfo.JobTitle,
        UserJobInfo.Department,
        AvgSalary.AvgSalary
    From TutorialAppSchema.Users AS Users
        LEFT JOIN TutorialAppSchema.UserSalary AS UserSalary
        ON UserSalary.UserId = Users.UserId
        LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
        ON UserJobInfo.UserId = Users.UserId
    OUTER APPLY (
        SELECT AVG(UserSalary2.Salary) AvgSalary
        From TutorialAppSchema.Users AS Users
            LEFT JOIN TutorialAppSchema.UserSalary AS UserSalary2
            ON UserSalary2.UserId = Users.UserId
            LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo2
            ON UserJobInfo2.UserId = Users.UserId
        WHERE UserJobInfo2.Department = UserJobInfo.Department
        GROUP BY UserJobInfo2.Department) AS AvgSalary
    WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
END
----------
USE DotNetCourseDatabase;
GO

ALTER PROCEDURE TutorialAppSchema.spUsers_Get
    /*EXEC TutorialAppSchema.spUsers_Get @UserId=3*/
    --Parameter
    @UserId INT = NULL
    , @Active BIT  = NULL

AS 
BEGIN
    --FOR OLD DATABASE VERSION
    IF OBJECT_ID('tempdb..#AverageDeptSalary', 'U') IS NOT NULL
        BEGIN
            DROP TABLE #AverageDeptSalary
        END
    --FOR NEW DATABASES
    --DROP TABLE IF EXISTS #AverageDeptSalary 
    SELECT UserJobInfo.Department
        , AVG(UserSalary.Salary) AvgSalary
        INTO #AverageDeptSalary
    From TutorialAppSchema.Users AS Users
        LEFT JOIN TutorialAppSchema.UserSalary AS UserSalary
        ON UserSalary.UserId = Users.UserId
        LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
        ON UserJobInfo.UserId = Users.UserId
    GROUP BY UserJobInfo.Department

    CREATE CLUSTERED INDEX cix_AverageDeptSalary_Department ON #AverageDeptSalary(Department)

    SELECT [Users].[UserId],
        [Users].[FirstName],
        [Users].[LastName],
        [Users].[Email],
        [Users].[Gender],
        [Users].[Active],
        UserSalary.Salary,
        UserJobInfo.JobTitle,
        UserJobInfo.Department,
        AvgSalary.AvgSalary
    From TutorialAppSchema.Users AS Users
        LEFT JOIN TutorialAppSchema.UserSalary AS UserSalary
        ON UserSalary.UserId = Users.UserId
        LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
        ON UserJobInfo.UserId = Users.UserId
    LEFT JOIN #AverageDeptSalary AS AvgSalary
        ON AvgSalary.Department = UserJobInfo.Department
    WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
        AND ISNULL(Users.Active, 0) = COALESCE(@Active, Users.Active, 0)
END
--------------
USE DotNetCourseDatabase;
GO

CREATE OR ALTER PROCEDURE TutorialAppSchema.spUser_Upsert
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(50),
    @Gender NVARCHAR(50),
    @JobTitle NVARCHAR(50),
    @Department NVARCHAR(50),
    @Salary DECIMAL(18,4),
    @Active BIT = 1,
    @UserId INT = NULL
AS
BEGIN
    IF NOT EXISTS (SELECT *
    FROM TutorialAppSchema.Users
    WHERE UserId = @UserId)
        BEGIN
        IF NOT EXISTS (SELECT *
        FROM TutorialAppSchema.Users
        WHERE Email = @Email)
        BEGIN
            DECLARE @OutputUserId INT

            INSERT INTO TutorialAppSchema.Users
                ([FirstName],
                [LastName],
                [Email],
                [Gender],
                [Active])
            VALUES
                (
                    @FirstName,
                    @LastName,
                    @Email,
                    @Gender,
                    @Active 
            )
            SET @OutputUserId = @@IDENTITY
            INSERT INTO TutorialAppSchema.UserSalary
                (
                UserId,
                Salary
                )
            VALUES
                (
                    @OutputUserId,
                    @Salary
            )
            INSERT INTO TutorialAppSchema.UserJobInfo
                (
                UserId,
                JobTitle,
                Department
                )
            VALUES
                (
                    @OutputUserId,
                    @JobTitle,
                    @Department
            )
        END
    END
    ELSE
        BEGIN
        UPDATE TutorialAppSchema.Users
        SET FirstName = @FirstName,
            LastName = @LastName,
            Email = @Email,
            Gender = @Gender,
            Active = @Active
    WHERE UserId = @UserId
        UPDATE TutorialAppSchema.UserSalary
        SET Salary = @Salary
        WHERE UserId = @UserId
        UPDATE TutorialAppSchema.UserJobInfo
        SET Department = @Department,
            JobTitle = @JobTitle
        WHERE UserId = @UserId
    END
END
------------
