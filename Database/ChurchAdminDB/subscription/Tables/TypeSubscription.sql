CREATE TABLE [subscription].[TypeSubscription] (
    [ID]          INT          NOT NULL,
    [Description] VARCHAR (60) NULL,
    [Timestamp]   DATETIME     CONSTRAINT [DF_TypeSubscription_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkTypeSubscription] PRIMARY KEY CLUSTERED ([ID] ASC)
);



