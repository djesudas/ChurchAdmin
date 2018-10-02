CREATE TABLE [harvest].[TypeProductDetails] (
    [ID]          INT           NOT NULL,
    [Description] VARCHAR (150) NULL,
    [ProductType] VARCHAR (50)  NULL,
    [UnitPrice]   MONEY         NULL,
    [Timestamp]   DATETIME      CONSTRAINT [DF_ProductDetails_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkTypeProductDetails] PRIMARY KEY CLUSTERED ([ID] ASC)
);

