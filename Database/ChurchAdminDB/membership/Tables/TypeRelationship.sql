CREATE TABLE [membership].[TypeRelationship] (
    [ID]          INT          NOT NULL,
    [Description] VARCHAR (60) NULL,
    [Timestamp]   DATETIME     CONSTRAINT [DF_TypeRelationship_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkTypeRelationship] PRIMARY KEY CLUSTERED ([ID] ASC)
);



