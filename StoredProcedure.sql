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
