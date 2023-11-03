--Create a login to SQL based on Windows account
CREATE LOGIN [<domainName>\<loginName>] FROM WINDOWS;
CREATE LOGIN [DESKTOP-CFCPFSG\JOBB] FROM WINDOWS;
--Grant reader permission
USE DotNetCourseDatabase
EXEC sp_addrolemember 'db_datareader', 'DESKTOP-CFCPFSG\JOBB';
--Grant owner permission
use DotNetCourseDatabase
exec sp_addrolemember 'db_owner', 'DESKTOP-CFCPFSG\JOBB';
