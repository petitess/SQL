DECLARE  @time VARCHAR(50) = FORMAT(GETDATE(), 'HH:mm')
DECLARE  @date VARCHAR(50) = FORMAT(GETDATE(), 'yyyy_MM_dd')
DECLARE  @month VARCHAR(50) = FORMAT(GETDATE(), 'yyyy_MM')
DECLARE  @olddate VARCHAR(50) = FORMAT(DATEADD(DAY, -35, GETDATE()), 'yyyy_MM')

DELETE FROM message WHERE subject LIKE '%SCRIPT%' AND subject LIKE '%@olddate%'

SELECT * FROM message WHERE subject LIKE '%SCRIPT%' AND subject LIKE '%@month%'

SELECT * FROM message WHERE subject LIKE '%@month%'

SELECT * FROM message WHERE subject LIKE '%'+FORMAT(DATEADD(DAY, 7, GETDATE()), 'yyyy_MM_dd')+'%'
SELECT FORMAT(DATEADD(DAY, -65, GETDATE()), 'yyyy_MM_dd')
SELECT DATEADD(year, 1, '2017/08/25') AS DateAdd;
