CREATE TABLE [dbo].[FactRides] (
    [RideKey]         BIGINT          IDENTITY NOT NULL,
    [RideID]          VARCHAR (30)    NOT NULL,
    [DateKey]         INT             NOT NULL,
    [CityKey]         BIGINT          NOT NULL,
    [DriverKey]       BIGINT          NOT NULL,
    [CustomerKey]     BIGINT          NOT NULL,
    [TripTypeKey]     BIGINT          NOT NULL,
    [PickupDateTime]  DATETIME2 (6)   NOT NULL,
    [DropoffDateTime] DATETIME2 (6)   NOT NULL,
    [DurationMinutes] DECIMAL (10, 2) NOT NULL,
    [DistanceMiles]   DECIMAL (10, 2) NOT NULL,
    [FareAmount]      DECIMAL (10, 2) NOT NULL,
    [DriverEarnings]  DECIMAL (10, 2) NOT NULL,
    [PlatformFee]     DECIMAL (10, 2) NOT NULL,
    [RideStatus]      VARCHAR (20)    NOT NULL
);


GO

ALTER TABLE [dbo].[FactRides]
    ADD CONSTRAINT [FK_FactRides_City] FOREIGN KEY ([CityKey]) REFERENCES [dbo].[DimCity] ([CityKey]) NOT ENFORCED;


GO

ALTER TABLE [dbo].[FactRides]
    ADD CONSTRAINT [FK_FactRides_Customer] FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomer] ([CustomerKey]) NOT ENFORCED;


GO

ALTER TABLE [dbo].[FactRides]
    ADD CONSTRAINT [FK_FactRides_Date] FOREIGN KEY ([DateKey]) REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED;


GO

ALTER TABLE [dbo].[FactRides]
    ADD CONSTRAINT [FK_FactRides_Driver] FOREIGN KEY ([DriverKey]) REFERENCES [dbo].[DimDriver] ([DriverKey]) NOT ENFORCED;


GO

ALTER TABLE [dbo].[FactRides]
    ADD CONSTRAINT [FK_FactRides_TripType] FOREIGN KEY ([TripTypeKey]) REFERENCES [dbo].[DimTripType] ([TripTypeKey]) NOT ENFORCED;


GO

ALTER TABLE [dbo].[FactRides]
    ADD CONSTRAINT [PK_FactRides] PRIMARY KEY NONCLUSTERED ([RideKey] ASC) NOT ENFORCED;


GO

ALTER TABLE [dbo].[FactRides]
    ADD CONSTRAINT [UQ_FactRides_RideID] UNIQUE NONCLUSTERED ([RideID] ASC) NOT ENFORCED;


GO