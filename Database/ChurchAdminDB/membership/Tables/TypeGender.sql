CREATE TABLE [membership].[TypeGender] (
    [ID]          INT          NOT NULL,
    [Description] VARCHAR (60) NULL,
    [Timestamp]   DATETIME     CONSTRAINT [DF_TypeGender_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [pkTypeGender] PRIMARY KEY CLUSTERED ([ID] ASC)
);



