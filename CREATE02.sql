CREATE TABLE WeatherInfo
(
    [Id] [int] IDENTITY (1,1) PRIMARY KEY,
    [City] [varchar] (50) NULL,
    [Temperature] [int] NULL,
    [Description] [varchar] (50) NULL,
    [TimeZone] [varchar] (50) NULL
)

INSERT WeatherInfo 
(
    [City],
    [Temperature],
    [Description],
    [TimeZone]
) VALUES
(
'Gothenburg',
-2,
'Cold',
'Europe/Stockholm'
)

SELECT * from [sqldb-weather-01].dbo.WeatherInfo

DROP TABLE WeatherInfo
