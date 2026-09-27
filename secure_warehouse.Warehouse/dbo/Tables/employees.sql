CREATE TABLE [dbo].[employees] (
    [emp_id]         INT             NULL,
    [name]           VARCHAR (100)   NULL,
    [department]     VARCHAR (50)    NULL,
    [region]         VARCHAR (50)    NULL,
    [salary]         DECIMAL (10, 2) NULL,
    [ssn]            VARCHAR (20)    NULL,
    [email]          VARCHAR (100)   NULL,
    [manager_region] VARCHAR (50)    NULL
);


GO