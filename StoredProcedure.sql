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
    -- SELECT UserJobInfo.Department
    -- , AVG(UserSalary.Salary) AvgSalary
    -- From TutorialAppSchema.Users AS Users
    --     LEFT JOIN TutorialAppSchema.UserSalary AS UserSalary
    --     ON UserSalary.UserId = Users.UserId
    --     LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
    --     ON UserJobInfo.UserId = Users.UserId
    -- GROUP BY UserJobInfo.Department

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
        GROUP BY UserJobInfo2.Department) AvgSalary
    WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
END
----------
