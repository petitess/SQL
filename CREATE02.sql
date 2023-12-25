CREATE TABLE WeatherInfo
(
    [Id] [int] IDENTITY (1,1) PRIMARY KEY,
    [City] [varchar] (50) NULL,
    [Temperature] [int] NULL,
    [Description] [varchar] (50) NULL,
    [Localtime] [varchar] (50) NULL,
    [TimeZone] [varchar] (50) NULL
)

INSERT WeatherInfo 
(
    [City],
    [Temperature],
    [Description],
    [Localtime],
    [TimeZone]
) VALUES
(
'Gothenburg',
-2,
'Cold',
'2023-12-25 12:00',
'Europe/Stockholm'
)

INSERT WeatherInfo 
(
    [City],
    [Temperature],
    [Description],
    [Localtime],
    [TimeZone]
) VALUES
(
'Gothenburg',
-2,
'Cold',
'2023-12-25 12:00',
'Europe/Stockholm'
)

USE [sqldb-weather-01]

SELECT * from [sqldb-weather-01].dbo.WeatherInfo

DROP TABLE WeatherInfo
