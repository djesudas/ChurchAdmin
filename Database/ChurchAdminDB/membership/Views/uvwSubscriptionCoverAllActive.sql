


CREATE VIEW [membership].[uvwSubscriptionCoverAllActive]
AS

-- Define the CTE expression name and column list.  
WITH MemberLabelWithPhone
AS  
-- Define the CTE query.  
(  
SELECT        membership.MemberDetails.FamilyID, membership.MemberDetails.MemberID, NULLIF (membership.TypeTitle.Description, '') + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberInitials, ''), '') 
                         + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberFirstName, ''), '') + COALESCE (' ' + NULLIF (membership.MemberDetails.MemberMiddleName, ''), '') 
                         + COALESCE (' ' + NULLIF (membership.MemberDetails.MemberLastName, ''), '') AS MemberFullName, COALESCE (NULLIF (membership.FamilyDetails.DoorFlatNo, '') 
                         + COALESCE (', ' + NULLIF (membership.FamilyDetails.BuildingName, ''), ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.StreetName, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.NagarName, ''), '') 
                         + COALESCE (', ' + NULLIF (membership.FamilyDetails.AreaName, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.Landmark, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.City, ''), '') 
                         + COALESCE (', ' + NULLIF (CAST(membership.FamilyDetails.Pincode AS varchar(10)), ''), '') AS MemberAddress, membership.TypeGender.Description AS GenderDescription, 
						 CASE WHEN membership.MemberDetails.SubscriptionNumber IS NULL THEN '-'
							  WHEN membership.MemberDetails.SubscriptionNumber = '' THEN '-'
						 ELSE membership.MemberDetails.SubscriptionNumber
						 END AS SubscriptionNumber, 
						 membership.MemberDetails.DateOfBirth, 
						 FLOOR((CAST (GetDate() AS INTEGER) - CAST(membership.MemberDetails.DateOfBirth AS INTEGER)) / 365.25) AS Age,
						 membership.TypeMaritalStatus.Description AS MaritalStatusDescription, 
						 membership.MemberDetails.AnniversaryDate,
						 membership.TypeRelationship.Description AS RelationshipDescription, 
                         CASE WHEN membership.MemberDetails.Mobile IS NULL THEN '-'
							  WHEN membership.MemberDetails.Mobile = '' THEN '-'
						 ELSE membership.MemberDetails.Mobile
						 END AS Mobile, 
						 CASE WHEN membership.FamilyDetails.HomePhone IS NULL THEN '-'
							  WHEN membership.FamilyDetails.HomePhone = '' THEN '-'
						 ELSE membership.FamilyDetails.HomePhone
						 END AS HomePhone, 
						 membership.TypeFamilyStatus.Description AS StatusDescription, 
						 membership.TypeFamilyInActiveStatusReason.Description AS InActiveStatusDescription, 
                         membership.MemberDetails.MemberStatusTypeID AS MemberStatus,
						 membership.MemberDetails.RelationshipTypeID AS Relationship, membership.MemberDetails.MaritalStatusTypeID AS MaritalStatus
FROM            membership.MemberDetails INNER JOIN
                         membership.TypeRelationship ON membership.MemberDetails.RelationshipTypeID = membership.TypeRelationship.ID LEFT OUTER JOIN
                         membership.FamilyDetails ON membership.MemberDetails.FamilyID = membership.FamilyDetails.FamilyID LEFT OUTER JOIN
                         membership.TypeGender ON membership.MemberDetails.GenderTypeID = membership.TypeGender.ID LEFT OUTER JOIN
						 membership.TypeMaritalStatus ON membership.MemberDetails.MaritalStatusTypeID = membership.TypeMaritalStatus.ID LEFT OUTER JOIN
                         membership.TypeFamilyStatus ON membership.MemberDetails.MemberStatusTypeID = membership.TypeFamilyStatus.ID LEFT OUTER JOIN
                         membership.TypeFamilyInActiveStatusReason ON membership.MemberDetails.MemberStatusInactiveReasonTypeID = membership.TypeFamilyInActiveStatusReason.ID LEFT OUTER JOIN
                         membership.TypeTitle ON membership.MemberDetails.TitleTypeID = membership.TypeTitle.ID

WHERE membership.MemberDetails.MemberStatusTypeID = 1 and 
      membership.MemberDetails.SubscriptionNumber IS NOT NULL  and
	  membership.MemberDetails.SubscriptionNumber <> '' 
	  and membership.MemberDetails.FamilyID in (129)
)  
-- Define the outer query referencing the CTE name.  
SELECT MemberLabelWithPhone.[FamilyID]
      ,MemberLabelWithPhone.[MemberID]
      ,MemberLabelWithPhone.[MemberFullName]
      ,MemberLabelWithPhone.[MemberAddress]
      ,MemberLabelWithPhone.[GenderDescription]
      ,MemberLabelWithPhone.[SubscriptionNumber]
      ,MemberLabelWithPhone.[DateOfBirth]
      ,MemberLabelWithPhone.[Age]
      ,MemberLabelWithPhone.[MaritalStatusDescription]
      ,MemberLabelWithPhone.[AnniversaryDate]
      ,MemberLabelWithPhone.[RelationshipDescription]
      ,CASE 
			WHEN MemberLabelWithPhone.Mobile IS NULL OR MemberLabelWithPhone.Mobile = '-' THEN 
				(SELECT MemMob.Mobile FROM membership.MemberDetails MemMob WHERE MemMob.FamilyID = MD.FamilyID AND MemMob.RelationshipTypeID=1)
			ELSE 
				MemberLabelWithPhone.[Mobile]
		END AS Mobile
      ,MemberLabelWithPhone.[HomePhone]
      ,MemberLabelWithPhone.[StatusDescription]
      ,MemberLabelWithPhone.[InActiveStatusDescription]
      ,MemberLabelWithPhone.[MemberStatus]
      ,MemberLabelWithPhone.[Relationship]
      ,MemberLabelWithPhone.[MaritalStatus]
FROM MemberLabelWithPhone  
INNER JOIN 
membership.MemberDetails MD ON MD.FamilyID = MemberLabelWithPhone.FamilyID AND MD.MemberID = MemberLabelWithPhone.MemberID