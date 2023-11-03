```sql
--Create a database
CREATE DATABASE DotNetCourseDatabase
GO

USE DotNetCourseDatabase
GO

CREATE SCHEMA TutorialAppSchema
GO

CREATE TABLE TutorialAppSchema.Computer(
	ComputerId INT IDENTITY(1,1) PRIMARY KEY,
	Motherboard NVARCHAR(50),
	CPUCores INT,
	HasWifi BIT,
	HasLTE BIT,
	ReleaseDate DATE,
	Price DECIMAL(18,4),
	VideoCard NVARCHAR(50)
);

SELECT * FROM TutorialAppSchema.Computer
-----------------------
--Create a login to SQL based on Windows account
CREATE LOGIN [<domainName>\<loginName>] FROM WINDOWS;
CREATE LOGIN [DESKTOP-CFCPFSG\JOBB] FROM WINDOWS;
--Grant reader permission
USE DotNetCourseDatabase
EXEC sp_addrolemember 'db_datareader', 'DESKTOP-CFCPFSG\JOBB';
--Grant owner permission
use DotNetCourseDatabase
exec sp_addrolemember 'db_owner', 'DESKTOP-CFCPFSG\JOBB';
--Clear a database
USE DotNetCourseDatabase;
GO
TRUNCATE TABLE TutorialAppSchema.Computer
--SELECT
SELECT * FROM TutorialAppSchema.Computer
SELECT * FROM TutorialAppSchema.Computer WHERE Motherboard = 'Voonte'
SELECT * FROM TutorialAppSchema.Computer WHERE ReleaseDate < '2020-01-01'
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
SET IDENTITY TutorialAppSchema.Computer ON --Let's user change IDENTITY
--- CHAR(10) 
--- VARCHAR(10) - 
--- NVARCHAR(255) - accepts symbols
--- BIT - bool
--- DECIMAL(18, 4)
--INSERT DATA
INSERT INTO TutorialAppSchema.Computer
    (
    [Motherboard],
    [CPUCores],
    [HasWifi],
    [HasLTE],
    [ReleaseDate],
    [Price],
    [VideoCard]
    )
VALUES
    (
        'Sample-Motherboard',
        4,
        2,
        0,
        '2022-01-01',
        1000,
        'NVIDIA'
    )
--DELETE
DELETE FROM TutorialAppSchema.Computer WHERE ComputerId = 302
--UPDATE
UPDATE TutorialAppSchema.Computer SET CPUCores = 4 WHERE Motherboard = 'Voonte'
--

```
