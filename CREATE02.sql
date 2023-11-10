USE DotNetCourseDatabase;
GO

CREATE TABLE TutorialAppSchema.Auth (
    Email NVARCHAR(100)
    , PasswordHash VARBINARY(MAX)
    , PasswordSalt VARBINARY(MAX)
)

SELECT * FROM TutorialAppSchema.Auth
