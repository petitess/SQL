DECLARE @dbName VARCHAR(50) = 'centrum_cgmj4'
DECLARE  @date VARCHAR(50) = FORMAT(GETDATE(), 'yyyy_MM_dd_HH_mm')
DECLARE @part1 VARCHAR(250) = 'https://stbackupXprod01.blob.core.windows.net/vmsqlprod02-full-backup/' + @dbName + '_' + @date + '_1.bak'
DECLARE @part2 VARCHAR(250) = 'https://stbackupXprod01.blob.core.windows.net/vmsqlprod02-full-backup/' + @dbName + '_' + @date + '_2.bak'
DECLARE @part3 VARCHAR(250) = 'https://stbackupXprod01.blob.core.windows.net/vmsqlprod02-full-backup/' + @dbName + '_' + @date + '_3.bak'
DECLARE @part4 VARCHAR(250) = 'https://stbackupXprod01.blob.core.windows.net/vmsqlprod02-full-backup/' + @dbName + '_' + @date + '_4.bak';
BACKUP DATABASE @dbName
TO URL = @part1,
URL = @part2,
URL = @part3,
URL = @part4
WITH COMPRESSION, MAXTRANSFERSIZE = 4194304, BLOCKSIZE = 65536;
