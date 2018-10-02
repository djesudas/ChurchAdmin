


CREATE VIEW [membership].[uvwMemberDetails]
AS
SELECT        membership.MemberDetails.FamilyID, membership.MemberDetails.MemberID, membership.TypeTitle.Description AS TitleDescription, ISNULL(membership.MemberDetails.MemberFirstName, '') 
                         + ' ' + ISNULL(membership.MemberDetails.MemberInitials, '') AS MemberName, membership.MemberDetails.MemberInitials, membership.MemberDetails.MemberFirstName, membership.MemberDetails.MemberMiddleName, 
                         membership.MemberDetails.MemberLastName, ISNULL(membership.MemberDetails.SubscriptionNumber, 'NA') AS SubscriptionNumber, membership.TypeRelationship.Description AS RelationshipDescription, 
                         membership.TypeGender.Description AS GenderDescription, membership.TypeMaritalStatus.Description AS MaritalStatusDescription, membership.TypeFamilyStatus.Description AS StatusDescription, membership.MemberDetails.DateOfBirth, 
                         membership.MemberDetails.AnniversaryDate, membership.MemberDetails.Baptised, membership.MemberDetails.Confirmed, membership.MemberDetails.BaptismDate, membership.MemberDetails.ConfirmationDate, 
                         membership.MemberDetails.Mobile, membership.MemberDetails.AlternateMobile1, membership.MemberDetails.AlternateMobile2, membership.MemberDetails.Email, 
                         membership.TypeFamilyInActiveStatusReason.Description AS InActiveStatusDescription, membership.MemberDetails.MembershipSince, membership.MemberDetails.Notes,
						 ISNULL(membership.FamilyDetails.DoorFlatNo, '') 
                         + ',' + ISNULL(membership.FamilyDetails.BuildingName, '') 
						 + ',' + ISNULL(membership.FamilyDetails.StreetName, '')
						 + ',' + ISNULL(membership.FamilyDetails.NagarName, '')
						 + ',' + ISNULL(membership.FamilyDetails.AreaName, '')
						 + ',' + ISNULL(membership.FamilyDetails.Landmark, '')
						 + ',' + ISNULL(membership.FamilyDetails.City, '')
						 + ',' + ISNULL(CAST(membership.FamilyDetails.Pincode AS nvarchar), '')
						 AS MemberAddress
FROM            membership.MemberDetails LEFT OUTER JOIN
                         membership.TypeFamilyInActiveStatusReason ON membership.MemberDetails.MemberStatusInactiveReasonTypeID = membership.TypeFamilyInActiveStatusReason.ID LEFT OUTER JOIN
                         membership.TypeFamilyStatus ON membership.MemberDetails.MemberStatusTypeID = membership.TypeFamilyStatus.ID LEFT OUTER JOIN
                         membership.TypeGender ON membership.MemberDetails.GenderTypeID = membership.TypeGender.ID LEFT OUTER JOIN
                         membership.TypeMaritalStatus ON membership.MemberDetails.MaritalStatusTypeID = membership.TypeMaritalStatus.ID LEFT OUTER JOIN
                         membership.TypeRelationship ON membership.MemberDetails.RelationshipTypeID = membership.TypeRelationship.ID LEFT OUTER JOIN
                         membership.TypeTitle ON membership.MemberDetails.TitleTypeID = membership.TypeTitle.ID left outer join
						 membership.FamilyDetails ON membership.FamilyDetails.FamilyID = membership.MemberDetails.FamilyID
WHERE        (membership.MemberDetails.MemberStatusTypeID = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'membership', @level1type = N'VIEW', @level1name = N'uvwMemberDetails';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'          Top = 234
               Left = 290
               Bottom = 347
               Right = 462
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
', @level0type = N'SCHEMA', @level0name = N'membership', @level1type = N'VIEW', @level1name = N'uvwMemberDetails';


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
            TopColumn = 41
         End
         Begin Table = "TypeFamilyInActiveStatusReason (membership)"
            Begin Extent = 
               Top = 6
               Left = 321
               Bottom = 119
               Right = 545
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeFamilyStatus (membership)"
            Begin Extent = 
               Top = 6
               Left = 583
               Bottom = 119
               Right = 764
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeGender (membership)"
            Begin Extent = 
               Top = 120
               Left = 321
               Bottom = 233
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeMaritalStatus (membership)"
            Begin Extent = 
               Top = 120
               Left = 546
               Bottom = 233
               Right = 764
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeRelationship (membership)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeTitle (membership)"
            Begin Extent = 
     ', @level0type = N'SCHEMA', @level0name = N'membership', @level1type = N'VIEW', @level1name = N'uvwMemberDetails';

