CREATE TABLE [membership].[FamilyDetails] (
    [FamilyID]                        INT           NOT NULL,
    [TitleTypeID]                     INT           NOT NULL,
    [FamilyHeadInitials]              VARCHAR (15)  NULL,
    [FamilyHeadFirstName]             VARCHAR (150) NULL,
    [FamilyHeadMiddleName]            VARCHAR (100) NULL,
    [FamilyHeadLastName]              VARCHAR (100) NULL,
    [FamilyStatusTypeID]              INT           NULL,
    [DoorFlatNo]                      VARCHAR (20)  NULL,
    [BuildingName]                    VARCHAR (60)  NULL,
    [StreetName]                      VARCHAR (100) NULL,
    [NagarName]                       VARCHAR (60)  NULL,
    [AreaName]                        VARCHAR (50)  NULL,
    [Landmark]                        VARCHAR (100) NULL,
    [City]                            VARCHAR (50)  NULL,
    [Pincode]                         INT           NULL,
    [HomePhone]                       VARCHAR (20)  NULL,
    [AlternateHomePhone1]             VARCHAR (20)  NULL,
    [MembershipSince]                 DATETIME      NULL,
    [PreviousMembershipChurchAddress] VARCHAR (150) NULL,
    [Timestamp]                       DATETIME      CONSTRAINT [DF_FamilyDetails_Timestamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_FamilyDetails] PRIMARY KEY CLUSTERED ([FamilyID] ASC),
    CONSTRAINT [FK_FamilyDetails_TypeFamilyStatus] FOREIGN KEY ([FamilyStatusTypeID]) REFERENCES [membership].[TypeFamilyStatus] ([ID]),
    CONSTRAINT [FK_FamilyDetails_TypeTitle] FOREIGN KEY ([TitleTypeID]) REFERENCES [membership].[TypeTitle] ([ID])
);





