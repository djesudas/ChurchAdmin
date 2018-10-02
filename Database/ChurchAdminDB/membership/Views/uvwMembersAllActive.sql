




CREATE VIEW [membership].[uvwMembersAllActive]
AS
SELECT        membership.MemberDetails.FamilyID, membership.MemberDetails.MemberID, NULLIF (membership.TypeTitle.Description, '') + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberInitials, ''), '') 
                         + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberFirstName, ''), '') + COALESCE (' ' + NULLIF (membership.MemberDetails.MemberMiddleName, ''), '') 
                         + COALESCE (' ' + NULLIF (membership.MemberDetails.MemberLastName, ''), '') AS MemberFullName, COALESCE (NULLIF (membership.FamilyDetails.DoorFlatNo, '') 
                         + COALESCE (', ' + NULLIF (membership.FamilyDetails.BuildingName, ''), ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.StreetName, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.NagarName, ''), '') 
                         + COALESCE (', ' + NULLIF (membership.FamilyDetails.AreaName, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.Landmark, ''), '') + COALESCE (', ' + NULLIF (membership.FamilyDetails.City, ''), '') 
                         + COALESCE (', ' + NULLIF (CAST(membership.FamilyDetails.Pincode AS varchar(10)), ''), '') AS MemberAddress, membership.TypeGender.Description AS GenderDescription, 
						 CASE WHEN membership.MemberDetails.SubscriptionNumber IS NULL THEN '-'
						 ELSE membership.MemberDetails.SubscriptionNumber
						 END AS SubscriptionNumber, 
						 membership.MemberDetails.DateOfBirth, 
						 FLOOR((CAST (GetDate() AS INTEGER) - CAST(membership.MemberDetails.DateOfBirth AS INTEGER)) / 365.25) AS Age,
						 membership.TypeMaritalStatus.Description AS MaritalStatusDescription, 
						 membership.MemberDetails.AnniversaryDate,
						 membership.TypeRelationship.Description AS RelationshipDescription, 
                         CASE WHEN membership.MemberDetails.Mobile IS NULL THEN '-'
						 ELSE membership.MemberDetails.Mobile
						 END AS Mobile, 
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

WHERE membership.MemberDetails.MemberStatusTypeID = 1