

CREATE VIEW [harvest].[uvwSaleDetails]
AS
SELECT        harvest.HarvestSale.SaleID, harvest.HarvestSale.FamilyID, harvest.HarvestSale.MemberID, 
						 CASE WHEN harvest.HarvestSale.FamilyID IS NULL THEN harvest.HarvestSale.MemberName
						 ELSE
						 COALESCE(NULLIF(membership.TypeTitle.Description, '') +
						 COALESCE('. ' + NULLIF(membership.MemberDetails.MemberInitials, ''), ''), '') +
						 COALESCE('. ' + NULLIF(membership.MemberDetails.MemberFirstName, ''), '') +
						 COALESCE(' ' + NULLIF(membership.MemberDetails.MemberMiddleName, ''), '') +
						 COALESCE(' ' + NULLIF(membership.MemberDetails.MemberLastName, ''), '') 
						 END AS MemberFullName,
						 COALESCE(NULLIF(membership.FamilyDetails.DoorFlatNo, '') +
						 COALESCE(', ' + NULLIF(membership.FamilyDetails.BuildingName, ''), ''), '') +
						 COALESCE(', ' + NULLIF(membership.FamilyDetails.StreetName, ''), '') +
						 COALESCE(', ' + NULLIF(membership.FamilyDetails.NagarName, ''), '') +
						 COALESCE(', ' + NULLIF(membership.FamilyDetails.AreaName, ''), '') +
						 COALESCE(', ' + NULLIF(membership.FamilyDetails.Landmark, ''), '') +
						 COALESCE(', ' + NULLIF(membership.FamilyDetails.City, ''), '') +
						 COALESCE(', ' + NULLIF((CAST(membership.FamilyDetails.Pincode as varchar(10))), ''), '') as MemberAddress,
						 CASE WHEN membership.MemberDetails.SubscriptionNumber IS NULL THEN 'NA' 
						 ELSE membership.MemberDetails.SubscriptionNumber 
						 END AS SubscriptionNumber, 
						 harvest.TypeProductDetails.Description AS ProductDescription, 
						 harvest.HarvestSale.SaleItems, 
                         harvest.HarvestSale.SaleValue, 
						 membership.TypeRelationship.Description AS RelationshipDescription,
						 CASE WHEN membership.MemberDetails.Mobile IS NULL THEN 'NA' 
						 ELSE membership.MemberDetails.Mobile
						 END AS Mobile,
						 harvest.HarvestSale.Timestamp 

FROM            harvest.HarvestSale left outer JOIN
						 membership.MemberDetails ON harvest.HarvestSale.MemberID = membership.MemberDetails.MemberID AND
												     harvest.HarvestSale.FamilyID = membership.MemberDetails.FamilyID left outer JOIN
                         membership.FamilyDetails ON membership.MemberDetails.FamilyID  = membership.FamilyDetails.FamilyID left outer JOIN
                         membership.TypeTitle ON membership.FamilyDetails.TitleTypeID = membership.TypeTitle.ID AND membership.MemberDetails.TitleTypeID = membership.TypeTitle.ID left outer JOIN
                         membership.TypeRelationship ON membership.MemberDetails.RelationshipTypeID = membership.TypeRelationship.ID left outer JOIN
                         harvest.TypeProductDetails ON harvest.HarvestSale.ProductID = harvest.TypeProductDetails.ID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'harvest', @level1type = N'VIEW', @level1name = N'uvwSaleDetails';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'nd
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
', @level0type = N'SCHEMA', @level0name = N'harvest', @level1type = N'VIEW', @level1name = N'uvwSaleDetails';


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
         Begin Table = "HarvestSale (harvest)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "FamilyDetails (membership)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 528
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "MemberDetails (membership)"
            Begin Extent = 
               Top = 6
               Left = 566
               Bottom = 136
               Right = 811
            End
            DisplayFlags = 280
            TopColumn = 26
         End
         Begin Table = "TypeTitle (membership)"
            Begin Extent = 
               Top = 6
               Left = 849
               Bottom = 119
               Right = 1021
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeRelationship (membership)"
            Begin Extent = 
               Top = 6
               Left = 1059
               Bottom = 119
               Right = 1273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductDetails (harvest)"
            Begin Extent = 
               Top = 120
               Left = 849
               Bottom = 250
               Right = 1040
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
      E', @level0type = N'SCHEMA', @level0name = N'harvest', @level1type = N'VIEW', @level1name = N'uvwSaleDetails';

