CREATE TABLE [membership].[TypeTitle] (
    [ID]          INT          NOT NULL,
    [Description] VARCHAR (60) NULL,
    [Timestamp]   DATETIME     CONSTRAINT [DF_TypeTitle_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkTypeTitle] PRIMARY KEY CLUSTERED ([ID] ASC)
);



