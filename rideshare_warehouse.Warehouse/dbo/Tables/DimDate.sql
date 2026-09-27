CREATE TABLE [dbo].[DimDate] (
    [DateKey]     INT          NOT NULL,
    [FullDate]    DATE         NOT NULL,
    [DayOfMonth]  SMALLINT     NOT NULL,
    [DayName]     VARCHAR (10) NOT NULL,
    [DayOfWeek]   SMALLINT     NOT NULL,
    [IsWeekend]   BIT          NOT NULL,
    [MonthNumber] SMALLINT     NOT NULL,
    [MonthName]   VARCHAR (10) NOT NULL,
    [Quarter]     SMALLINT     NOT NULL,
    [Year]        SMALLINT     NOT NULL,
    [YearMonth]   CHAR (7)     NOT NULL
);


GO

ALTER TABLE [dbo].[DimDate]
    ADD CONSTRAINT [PK_DimDate] PRIMARY KEY NONCLUSTERED ([DateKey] ASC) NOT ENFORCED;


GO