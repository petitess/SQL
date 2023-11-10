USE Demo_cgmj4
GO

DECLARE  @time VARCHAR(50) = FORMAT(GETDATE(), 'HH:mm')
DECLARE  @date VARCHAR(50) = FORMAT(GETDATE(), 'yyyy_MM_dd')
DECLARE  @olddate VARCHAR(50) = FORMAT(DATEADD(DAY, 7, GETDATE()), 'yyyy_MM_dd')

DELETE FROM message WHERE subject LIKE '%'+@olddate+'%'

INSERT INTO message
    (
    [sender],
    [subject],
    [text]
    )
VALUES
    (
        1,
        'SCRIPT_' + @date + '_' +  @time,
		'Det skapas automatiskt dagligen för att bekräfta backup. ' + @date + '_' +  @time
    )

--USE Demo_cgmj4
--GO
--SELECT * FROM message
