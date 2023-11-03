DECLARE @dbName VARCHAR(50) = 'kusten_read_cgmj4'
DECLARE @date VARCHAR(50) = FORMAT(GETDATE(), 'yyyy_MM_dd_HH_mm')
DECLARE @part1 VARCHAR(250) = 'https://stbackupXprod01.blob.core.windows.net/vmsqlprod02-transaction-log/' + @dbName + '_' + @date + '.bak';
BACKUP LOG @dbName
TO URL = @part1
WITH COMPRESSION, MAXTRANSFERSIZE = 4194304, BLOCKSIZE = 65536;
