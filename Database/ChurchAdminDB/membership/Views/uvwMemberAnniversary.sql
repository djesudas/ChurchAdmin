





CREATE VIEW [membership].[uvwMemberAnniversary]
AS
-- Define the CTE expression name and column list.  
WITH MemberAnniversaryWithPhone
AS  
-- Define the CTE query.  
(  
SELECT        membership.MemberDetails.FamilyID, 
						membership.MemberDetails.MemberID, 
						CASE WHEN membership.MemberDetails.GenderTypeID = 1 THEN
							'Mrs & Mr' + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberInitials, ''), '')
						ELSE
							NULLIF (membership.TypeTitle.Description, '') + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberInitials, ''), '') 
						END
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

WHERE membership.MemberDetails.AnniversaryDate IS NOT NULL AND 
	  membership.MemberDetails.MemberStatusTypeID = 1 AND
	  membership.MemberDetails.MaritalStatusTypeID = 2 AND
	  membership.MemberDetails.GenderTypeID = 1 
)  
-- Define the outer query referencing the CTE name.  
SELECT MemberAnniversaryWithPhone.[FamilyID]
      ,MemberAnniversaryWithPhone.[MemberID]
      ,MemberAnniversaryWithPhone.[MemberFullName]
	  ,MemberAnniversaryWithPhone.[HeadOfFamilyName]
      ,MemberAnniversaryWithPhone.[MemberAddress]
      ,MemberAnniversaryWithPhone.[GenderDescription]
      ,MemberAnniversaryWithPhone.[SubscriptionNumber]
	  ,CASE 
			WHEN MemberAnniversaryWithPhone.Mobile IS NULL THEN 
				(SELECT MemMob.Mobile FROM membership.MemberDetails MemMob WHERE MemMob.FamilyID = MD.FamilyID AND MemMob.RelationshipTypeID=1)
			ELSE 
				MemberAnniversaryWithPhone.[Mobile]
		END AS Mobile
      ,MemberAnniversaryWithPhone.[DateOfBirth]
      ,MemberAnniversaryWithPhone.[Age]
      ,MemberAnniversaryWithPhone.[MaritalStatusDescription]
      ,MemberAnniversaryWithPhone.[AnniversaryDate]
      ,MemberAnniversaryWithPhone.[RelationshipDescription]
      ,MemberAnniversaryWithPhone.[StatusDescription]
      ,MemberAnniversaryWithPhone.[InActiveStatusDescription]
      ,MemberAnniversaryWithPhone.[MemberStatus]
      ,MemberAnniversaryWithPhone.[Relationship]
      ,MemberAnniversaryWithPhone.[MaritalStatus]
FROM MemberAnniversaryWithPhone  
INNER JOIN 
membership.MemberDetails MD ON MD.FamilyID = MemberAnniversaryWithPhone.FamilyID AND MD.MemberID = MemberAnniversaryWithPhone.MemberID