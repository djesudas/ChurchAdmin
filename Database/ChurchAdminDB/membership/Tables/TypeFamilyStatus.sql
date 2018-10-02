CREATE TABLE [membership].[TypeFamilyStatus] (
    [ID]          INT          NOT NULL,
    [Description] VARCHAR (60) NULL,
    [Timestamp]   DATETIME     CONSTRAINT [DF_TypeFamilyStatus_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkTypeFamilyStatus] PRIMARY KEY CLUSTERED ([ID] ASC)
);



