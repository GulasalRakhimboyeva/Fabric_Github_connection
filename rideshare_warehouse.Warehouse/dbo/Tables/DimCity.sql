CREATE TABLE [dbo].[DimCity] (
    [CityKey]       BIGINT        IDENTITY NOT NULL,
    [CityID]        VARCHAR (20)  NOT NULL,
    [CityName]      VARCHAR (100) NOT NULL,
    [StateProvince] VARCHAR (100) NULL,
    [Country]       VARCHAR (100) NOT NULL,
    [Region]        VARCHAR (100) NULL,
    [TimeZone]      VARCHAR (50)  NULL
);


GO

ALTER TABLE [dbo].[DimCity]
    ADD CONSTRAINT [PK_DimCity] PRIMARY KEY NONCLUSTERED ([CityKey] ASC) NOT ENFORCED;


GO

ALTER TABLE [dbo].[DimCity]
    ADD CONSTRAINT [UQ_DimCity_CityID] UNIQUE NONCLUSTERED ([CityID] ASC) NOT ENFORCED;


GO