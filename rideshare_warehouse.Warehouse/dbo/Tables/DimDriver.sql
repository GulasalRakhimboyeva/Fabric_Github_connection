CREATE TABLE [dbo].[DimDriver] (
    [DriverKey]     BIGINT        IDENTITY NOT NULL,
    [DriverID]      VARCHAR (20)  NOT NULL,
    [DriverName]    VARCHAR (150) NOT NULL,
    [HomeCityKey]   BIGINT        NULL,
    [JoinDate]      DATE          NOT NULL,
    [DriverStatus]  VARCHAR (20)  NOT NULL,
    [VehicleType]   VARCHAR (50)  NULL,
    [EffectiveFrom] DATETIME2 (6) NOT NULL,
    [EffectiveTo]   DATETIME2 (6) NULL,
    [IsCurrent]     BIT           NOT NULL
);


GO

ALTER TABLE [dbo].[DimDriver]
    ADD CONSTRAINT [FK_DimDriver_City] FOREIGN KEY ([HomeCityKey]) REFERENCES [dbo].[DimCity] ([CityKey]) NOT ENFORCED;


GO

ALTER TABLE [dbo].[DimDriver]
    ADD CONSTRAINT [PK_DimDriver] PRIMARY KEY NONCLUSTERED ([DriverKey] ASC) NOT ENFORCED;


GO