CREATE TABLE [dbo].[FactCustomerMonthlySnapshot] (
    [SnapshotKey] BIGINT          IDENTITY NOT NULL,
    [YearMonth]   CHAR (7)        NOT NULL,
    [CustomerKey] BIGINT          NOT NULL,
    [RidesTaken]  INT             NOT NULL,
    [TotalSpend]  DECIMAL (12, 2) NOT NULL,
    [IsActive]    BIT             NOT NULL,
    [IsChurned]   BIT             NOT NULL
);


GO

ALTER TABLE [dbo].[FactCustomerMonthlySnapshot]
    ADD CONSTRAINT [FK_FactCustSnap_Customer] FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomer] ([CustomerKey]) NOT ENFORCED;


GO

ALTER TABLE [dbo].[FactCustomerMonthlySnapshot]
    ADD CONSTRAINT [PK_FactCustSnap] PRIMARY KEY NONCLUSTERED ([SnapshotKey] ASC) NOT ENFORCED;


GO

ALTER TABLE [dbo].[FactCustomerMonthlySnapshot]
    ADD CONSTRAINT [UQ_FactCustSnap_CustMonth] UNIQUE NONCLUSTERED ([CustomerKey] ASC, [YearMonth] ASC) NOT ENFORCED;


GO