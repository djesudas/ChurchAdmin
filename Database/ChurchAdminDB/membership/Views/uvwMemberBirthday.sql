




CREATE VIEW [membership].[uvwMemberBirthday]
AS
-- Define the CTE expression name and column list.  
WITH MemberBirthdayWithPhone  
AS  
-- Define the CTE query.  
(  
SELECT        membership.MemberDetails.FamilyID, 
						membership.MemberDetails.MemberID, 
						membership.MemberDetails.MemberFirstName,
						NULLIF (membership.TypeTitle.Description, '') + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberInitials, ''), '') 
                         + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberFirstName, ''), '') + COALESCE (' ' + NULLIF (membership.MemberDetails.MemberMiddleName, ''), '') 
                         + COALESCE (' ' + NULLIF (membership.MemberDetails.MemberLastName, ''), '') AS MemberFullName, 
						 NULLIF ((SELECT TT.Description FROM membership.TypeTitle TT
								  INNER JOIN membership.FamilyDetails FDIN ON FDIN.TitleTypeID=TT.ID AND FDIN.FamilyID = membership.FamilyDetails.FamilyID), '') 
						 + COALESCE ('. ' + NULLIF (membership.FamilyDetails.FamilyHeadInitials, ''), '') 
                         + COALESCE ('. ' + NULLIF (membership.FamilyDetails.FamilyHeadFirstName, ''), '') + COALESCE (' ' + NULLIF (membership.FamilyDetails.FamilyHeadMiddleName, ''), '') 
                         + COALESCE (' ' + NULLIF (membership.FamilyDetails.FamilyHeadLastName, ''), '') AS HeadOfFamilyName,
						 COALESCE (NULLIF (membership.FamilyDetails.DoorFlatNo, '') 
                         + COALESCE (', ' + NULLIF (membership.FamilyDetails.BuildingName, ''), ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.StreetName, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.NagarName, ''), '') 
                         + COALESCE (', ' + NULLIF (membership.FamilyDetails.AreaName, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.Landmark, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.City, ''), '') 
                         + COALESCE (', ' + NULLIF (CAST(membership.FamilyDetails.Pincode AS varchar(10)), ''), '') AS MemberAddress, 
						 membership.TypeGender.Description AS GenderDescription, 
						 membership.MemberDetails.SubscriptionNumber, 
						 membership.MemberDetails.Mobile, 
						 membership.MemberDetails.DateOfBirth, 
						 FLOOR((CAST (GetDate() AS INTEGER) - CAST(membership.MemberDetails.DateOfBirth AS INTEGER)) / 365.25) AS Age,
						 membership.TypeMaritalStatus.Description AS MaritalStatusDescription, 
						 membership.MemberDetails.AnniversaryDate, 
						 membership.TypeRelationship.Description AS RelationshipDescription, 
                         membership.TypeFamilyStatus.Description AS StatusDescription, 
						 membership.TypeFamilyInActiveStatusReason.Description AS InActiveStatusDescription, 
                         membership.MemberDetails.MemberStatusTypeID AS MemberStatus,
						 membership.MemberDetails.RelationshipTypeID AS Relationship, 
						 membership.MemberDetails.MaritalStatusTypeID AS MaritalStatus
FROM            membership.MemberDetails INNER JOIN
                         membership.TypeRelationship ON membership.MemberDetails.RelationshipTypeID = membership.TypeRelationship.ID LEFT OUTER JOIN
                         membership.FamilyDetails ON membership.MemberDetails.FamilyID = membership.FamilyDetails.FamilyID LEFT OUTER JOIN
                         membership.TypeGender ON membership.MemberDetails.GenderTypeID = membership.TypeGender.ID LEFT OUTER JOIN
						 membership.TypeMaritalStatus ON membership.MemberDetails.MaritalStatusTypeID = membership.TypeMaritalStatus.ID LEFT OUTER JOIN
                         membership.TypeFamilyStatus ON membership.MemberDetails.MemberStatusTypeID = membership.TypeFamilyStatus.ID LEFT OUTER JOIN
                         membership.TypeFamilyInActiveStatusReason ON membership.MemberDetails.MemberStatusInactiveReasonTypeID = membership.TypeFamilyInActiveStatusReason.ID LEFT OUTER JOIN
                         membership.TypeTitle ON membership.MemberDetails.TitleTypeID = membership.TypeTitle.ID

WHERE membership.MemberDetails.DateOfBirth IS NOT NULL AND 
	  membership.MemberDetails.MemberStatusTypeID = 1
)  
-- Define the outer query referencing the CTE name.  
SELECT MemberBirthdayWithPhone.[FamilyID]
      ,MemberBirthdayWithPhone.[MemberID]
      ,MemberBirthdayWithPhone.[MemberFirstName]
      ,MemberBirthdayWithPhone.[MemberFullName]
	  ,MemberBirthdayWithPhone.[HeadOfFamilyName]
      ,MemberBirthdayWithPhone.[MemberAddress]
      ,MemberBirthdayWithPhone.[GenderDescription]
      ,MemberBirthdayWithPhone.[SubscriptionNumber]
	  ,CASE 
			WHEN MemberBirthdayWithPhone.Mobile IS NULL THEN 
				(SELECT MemMob.Mobile FROM membership.MemberDetails MemMob WHERE MemMob.FamilyID = MD.FamilyID AND MemMob.RelationshipTypeID=1)
			ELSE 
				MemberBirthdayWithPhone.[Mobile]
		END AS Mobile
      ,MemberBirthdayWithPhone.[DateOfBirth]
      ,MemberBirthdayWithPhone.[Age]
      ,[MaritalStatusDescription]
      ,MemberBirthdayWithPhone.[AnniversaryDate]
      ,MemberBirthdayWithPhone.[RelationshipDescription]
      ,[StatusDescription]
      ,[InActiveStatusDescription]
      ,[MemberStatus]
      ,[Relationship]
      ,[MaritalStatus]  
FROM MemberBirthdayWithPhone  
LEFT OUTER JOIN 
membership.MemberDetails MD ON MD.FamilyID = MemberBirthdayWithPhone.FamilyID AND MD.MemberID = MemberBirthdayWithPhone.MemberID

WHERE MD.DateOfBirth IS NOT NULL 
	  AND MD.MemberStatusTypeID = 1
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'membership', @level1type = N'VIEW', @level1name = N'uvwMemberBirthday';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'270
               Left = 248
               Bottom = 383
               Right = 462
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeRelationship (membership)"
            Begin Extent = 
               Top = 120
               Left = 905
               Bottom = 233
               Right = 1119
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'membership', @level1type = N'VIEW', @level1name = N'uvwMemberBirthday';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MemberDetails (membership)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "FamilyDetails (membership)"
            Begin Extent = 
               Top = 7
               Left = 323
               Bottom = 137
               Right = 605
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeGender (membership)"
            Begin Extent = 
               Top = 6
               Left = 643
               Bottom = 119
               Right = 830
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeFamilyStatus (membership)"
            Begin Extent = 
               Top = 6
               Left = 868
               Bottom = 119
               Right = 1049
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeFamilyInActiveStatusReason (membership)"
            Begin Extent = 
               Top = 120
               Left = 643
               Bottom = 233
               Right = 867
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeTitle (membership)"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 383
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeRelationship_1"
            Begin Extent = 
               Top = ', @level0type = N'SCHEMA', @level0name = N'membership', @level1type = N'VIEW', @level1name = N'uvwMemberBirthday';

