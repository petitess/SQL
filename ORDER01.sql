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
-------------
SELECT * from [sqldb-weather-01].dbo.WeatherInfo ORDER by Id DESC

