CREATE TABLE [dbo].[DimCustomer] (
    [CustomerKey]   BIGINT        IDENTITY NOT NULL,
    [CustomerID]    VARCHAR (20)  NOT NULL,
    [CustomerName]  VARCHAR (150) NOT NULL,
    [Email]         VARCHAR (200) NULL,
    [LoyaltyTier]   VARCHAR (20)  NOT NULL,
    [SignupDate]    DATE          NOT NULL,
    [HomeCityKey]   BIGINT        NULL,
    [EffectiveFrom] DATETIME2 (6) NOT NULL,
    [EffectiveTo]   DATETIME2 (6) NULL,
    [IsCurrent]     BIT           NOT NULL
);


GO

ALTER TABLE [dbo].[DimCustomer]
    ADD CONSTRAINT [FK_DimCustomer_City] FOREIGN KEY ([HomeCityKey]) REFERENCES [dbo].[DimCity] ([CityKey]) NOT ENFORCED;


GO

ALTER TABLE [dbo].[DimCustomer]
    ADD CONSTRAINT [PK_DimCustomer] PRIMARY KEY NONCLUSTERED ([CustomerKey] ASC) NOT ENFORCED;


GO