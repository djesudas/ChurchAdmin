CREATE TABLE [harvest].[HarvestSale] (
    [SaleID]     INT           IDENTITY (1, 1) NOT NULL,
    [TokenID]    INT           NULL,
    [FamilyID]   INT           NULL,
    [MemberID]   INT           NULL,
    [MemberName] VARCHAR (300) NULL,
    [ProductID]  INT           NULL,
    [SaleItems]  VARCHAR (200) NULL,
    [SaleValue]  MONEY         NULL,
    [Timestamp]  DATETIME      CONSTRAINT [DF_HarvestSale_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkHarvestSale] PRIMARY KEY CLUSTERED ([SaleID] ASC),
    CONSTRAINT [fkHarvestSale_HarvestSale] FOREIGN KEY ([ProductID]) REFERENCES [harvest].[TypeProductDetails] ([ID])
);





