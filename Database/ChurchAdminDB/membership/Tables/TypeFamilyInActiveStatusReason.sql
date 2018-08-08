CREATE TABLE [membership].[TypeFamilyInActiveStatusReason] (
    [ID]          INT          NOT NULL,
    [Description] VARCHAR (60) NULL,
    [Timestamp]   DATETIME     CONSTRAINT [DF_TypeFamilyInActiveStatusReason_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkTypeFamilyInActiveStatusReason] PRIMARY KEY CLUSTERED ([ID] ASC)
);



