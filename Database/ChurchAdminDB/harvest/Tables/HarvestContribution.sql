CREATE TABLE [harvest].[HarvestContribution] (
    [ContributionID]    INT           IDENTITY (1, 1) NOT NULL,
    [TokenID]           INT           NULL,
    [FamilyID]          INT           NULL,
    [MemberID]          INT           NULL,
    [ProductID]         INT           NULL,
    [ContributionItems] VARCHAR (200) NULL,
    [ContributionValue] MONEY         NULL,
    [Timestamp]         DATETIME      CONSTRAINT [DF_HarvestContribution_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkHarvestContribution] PRIMARY KEY CLUSTERED ([ContributionID] ASC),
    CONSTRAINT [fkHarvestContribution_ProductDetails] FOREIGN KEY ([ProductID]) REFERENCES [harvest].[TypeProductDetails] ([ID])
);





