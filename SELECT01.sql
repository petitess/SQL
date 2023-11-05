SELECT UserSalary.UserId,
UserSalary.Salary,
UserSalary.AvgSalary 
FROM TutorialAppSchema.UserSalary
WHERE UserId = 5
--
SELECT * FROM TutorialAppSchema.Computer
SELECT * FROM TutorialAppSchema.Computer WHERE Motherboard = 'Voonte'
SELECT * FROM TutorialAppSchema.Computer WHERE ReleaseDate < '2020-01-01'
SELECT COUNT(*) FROM TutorialAppSchema.Users
SELECT [ComputerId]
[Motherboard],
ISNULL([CPUCores], 4) AS CPUCores,
[HasWifi],
[HasLTE],
[ReleaseDate],
[Price],
[VideoCard] FROM TutorialAppSchema.Computer
ORDER BY ReleaseDate DESC
--
SELECT [UserSalary].[UserId],
    [UserSalary].[Salary] 
FROM TutorialAppSchema.UserSalary AS UserSalary
    WHERE EXISTS (
        SELECT * FROM TutorialAppSchema.UserJobInfo AS UserJobInfo
            WHERE UserJobInfo.UserId = UserSalary.UserId)
                AND UserId <> 7
