CREATE TABLE [membership].[TypeMaritalStatus] (
    [ID]          INT          NOT NULL,
    [Description] VARCHAR (60) NULL,
    [Timestamp]   DATETIME     CONSTRAINT [DF_TypeMaritalStatus_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkTypeMaritalStatus] PRIMARY KEY CLUSTERED ([ID] ASC)
);



