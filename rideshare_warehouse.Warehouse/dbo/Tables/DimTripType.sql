CREATE TABLE [dbo].[DimTripType] (
    [TripTypeKey]     BIGINT       IDENTITY NOT NULL,
    [TripTypeCode]    VARCHAR (20) NOT NULL,
    [TripTypeName]    VARCHAR (50) NOT NULL,
    [VehicleCategory] VARCHAR (50) NULL
);


GO

ALTER TABLE [dbo].[DimTripType]
    ADD CONSTRAINT [PK_DimTripType] PRIMARY KEY NONCLUSTERED ([TripTypeKey] ASC) NOT ENFORCED;


GO

ALTER TABLE [dbo].[DimTripType]
    ADD CONSTRAINT [UQ_DimTripType_Code] UNIQUE NONCLUSTERED ([TripTypeCode] ASC) NOT ENFORCED;


GO