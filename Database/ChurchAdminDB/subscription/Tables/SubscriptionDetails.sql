CREATE TABLE [subscription].[SubscriptionDetails] (
    [ReceiptNumber]      INT           NOT NULL,
    [MemberID]           INT           NOT NULL,
    [FamilyID]           INT           NOT NULL,
    [SubscriptionNumber] VARCHAR (50)  NULL,
    [SubscriptionYear]   SMALLINT      NOT NULL,
    [SubscriptionMonth]  SMALLINT      NOT NULL,
    [SubscriptionTypeID] INT           NULL,
    [Amount]             MONEY         NOT NULL,
    [Notes]              VARCHAR (200) NULL,
    [Timestamp]          DATETIME      CONSTRAINT [DF_SubscriptionDetails_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkSubscriptionDetails] PRIMARY KEY CLUSTERED ([ReceiptNumber] ASC, [MemberID] ASC)
);



