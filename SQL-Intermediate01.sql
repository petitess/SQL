USE DotNetCourseDatabase
SELECT [Users].[UserId],
[Users].[FirstName] + ' ' + [Users].[LastName] AS FullName,
[Users].[Email],
[Users].[Gender],
[Users].[Active] 
FROM TutorialAppSchema.Users AS Users
WHERE Active = 1
ORDER By Users.UserId DESC
--merge tables
USE DotNetCourseDatabase
SELECT [Users].[UserId],
[Users].[FirstName] + ' ' + [Users].[LastName] AS FullName,
[Users].[Email],
[Users].[Gender],
[Users].[Active],
[UserJobInfo].[UserId],
[UserJobInfo].[JobTitle],
[UserJobInfo].[Department]
FROM TutorialAppSchema.Users AS Users
    --INNER JOIN
    JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
        ON UserJobInfo.UserId = Users.UserId
WHERE Active = 1
ORDER By Users.UserId DESC
--
USE DotNetCourseDatabase
SELECT [Users].[UserId],
[Users].[FirstName] + ' ' + [Users].[LastName] AS FullName,
[Users].[Email],
[Users].[Gender],
[Users].[Active],
[UserJobInfo].[UserId],
[UserJobInfo].[JobTitle],
[UserJobInfo].[Department]
FROM TutorialAppSchema.Users AS Users
    JOIN TutorialAppSchema.UserSalary AS UserSalary
        ON UserSalary.UserId = Users.UserId
    LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
        ON UserJobInfo.UserId = Users.UserId
WHERE Active = 1
ORDER By Users.UserId DESC
--make a query run faster
CREATE CLUSTERED INDEX cix_UserSalary_UserId ON TutorialAppSchema.UserSalary(UserId)
CREATE NONCLUSTERED INDEX ix_UserSalary_UserId ON TutorialAppSchema.UserSalary(Salary) INCLUDE (UserId)
CREATE NONCLUSTERED INDEX ix_UserJobInfo_JobTitle ON TutorialAppSchema.UserJobInfo(JobTitle) INCLUDE (Department)
CREATE NONCLUSTERED INDEX fix_Users_Active ON TutorialAppSchema.Users(Active) 
INCLUDE ([Email], [FirstName], [LastName]) --Also includes UserId because it is clustered Index
    WHERE Active = 1
--
DELETE FROM TutorialAppSchema.UserSalary WHERE UserId > 500
--when we use BETWEEN we also include the Lower and Upper Bound of the value we're checking
DELETE FROM TutorialAppSchema.UserSalary WHERE UserId BETWEEN 250 AND 500
--
SELECT [UserSalary].[UserId],
    [UserSalary].[Salary] 
FROM TutorialAppSchema.UserSalary AS UserSalary
    WHERE EXISTS (
        SELECT * FROM TutorialAppSchema.UserJobInfo AS UserJobInfo
            WHERE UserJobInfo.UserId = UserSalary.UserId)
                AND UserId <> 7
--merge tables
SELECT [UserId],
[Salary] FROM TutorialAppSchema.UserSalary
-- UNION --Distinct between two datasets
UNION ALL --Merge all data
SELECT [UserId],
[Salary] FROM TutorialAppSchema.UserSalary
--count salary per department
USE DotNetCourseDatabase
SELECT ISNULL([UserJobInfo].[Department], 'No Department Listed') AS Department,
 SUM([UserSalary].[Salary]) AS Salary,
 MIN([UserSalary].[Salary]) AS MinSalary,
 MAX([UserSalary].[Salary]) AS MaxSalary,
 AVG([UserSalary].[Salary]) AS AvgSalary,
 COUNT(*) AS PeopleInDepartment,
 STRING_AGG(Users.UserId, ',') AS UserIds
FROM TutorialAppSchema.Users AS Users
    JOIN TutorialAppSchema.UserSalary AS UserSalary
        ON UserSalary.UserId = Users.UserId
    LEFT JOIN TutorialAppSchema.UserJobInfo AS UserJobInfo
        ON UserJobInfo.UserId = Users.UserId
WHERE Active = 1
GROUP BY [UserJobInfo].[Department]
ORDER By UserJobInfo.Department DESC
--date functions
SELECT GETDATE()
SELECT FORMAT(GETDATE(), 'yyyy_MM_dd_HH_mm')
SELECT DATEADD(HOUR, 2, GETDATE())
SELECT FORMAT(DATEADD(HOUR, 2, GETDATE()), 'yyyy_MM_dd_HH_mm')
SELECT DATEDIFF(HOUR, GETDATE(), DATEADD(HOUR, 2, GETDATE()))
SELECT DATEDIFF(MINUTE, GETDATE(), DATEADD(HOUR, 2, GETDATE()))
