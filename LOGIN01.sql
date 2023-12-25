--Create a login to SQL based on Windows account
CREATE LOGIN [<domainName>\<loginName>] FROM WINDOWS;
CREATE LOGIN [DESKTOP-CFCPFSG\JOBB] FROM WINDOWS;
--Grant reader permission
USE DotNetCourseDatabase
EXEC sp_addrolemember 'db_datareader', 'DESKTOP-CFCPFSG\JOBB';
--Grant owner permission
use DotNetCourseDatabase
exec sp_addrolemember 'db_owner', 'DESKTOP-CFCPFSG\JOBB';
--Add managed identity
CREATE USER [func-weather-prod-01] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [func-weather-prod-01]
ALTER ROLE db_datawriter ADD MEMBER [func-weather-prod-01]
