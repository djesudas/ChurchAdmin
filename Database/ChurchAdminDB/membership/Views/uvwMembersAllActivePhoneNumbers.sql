

CREATE VIEW [membership].[uvwMembersAllActivePhoneNumbers]
AS
SELECT        membership.MemberDetails.FamilyID, membership.MemberDetails.MemberID, NULLIF (membership.TypeTitle.Description, '') + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberInitials, ''), '') 
                         + COALESCE ('. ' + NULLIF (membership.MemberDetails.MemberFirstName, ''), '') + COALESCE (' ' + NULLIF (membership.MemberDetails.MemberMiddleName, ''), '') 
                         + COALESCE (' ' + NULLIF (membership.MemberDetails.MemberLastName, ''), '') AS MemberFullName, membership.TypeGender.Description AS GenderDescription, 
						 CASE WHEN membership.MemberDetails.SubscriptionNumber IS NULL THEN '-'
						 ELSE membership.MemberDetails.SubscriptionNumber
						 END AS SubscriptionNumber, 
						 membership.TypeRelationship.Description AS RelationshipDescription, 
                         CASE WHEN membership.MemberDetails.Mobile IS NULL THEN '-'
						 ELSE membership.MemberDetails.Mobile
						 END AS Mobile, 
						 CASE WHEN membership.MemberDetails.AlternateMobile1 IS NULL THEN '-'
						 ELSE membership.MemberDetails.AlternateMobile1
						 END AS Mobile1, 
						 CASE WHEN membership.MemberDetails.AlternateMobile2 IS NULL THEN '-'
						 ELSE membership.MemberDetails.AlternateMobile2
						 END AS Mobile2, 
						 membership.TypeFamilyStatus.Description AS StatusDescription
FROM            membership.MemberDetails INNER JOIN
                         membership.TypeRelationship ON membership.MemberDetails.RelationshipTypeID = membership.TypeRelationship.ID LEFT OUTER JOIN
                         membership.FamilyDetails ON membership.MemberDetails.FamilyID = membership.FamilyDetails.FamilyID LEFT OUTER JOIN
                         membership.TypeGender ON membership.MemberDetails.GenderTypeID = membership.TypeGender.ID LEFT OUTER JOIN
						 membership.TypeMaritalStatus ON membership.MemberDetails.MaritalStatusTypeID = membership.TypeMaritalStatus.ID LEFT OUTER JOIN
                         membership.TypeFamilyStatus ON membership.MemberDetails.MemberStatusTypeID = membership.TypeFamilyStatus.ID LEFT OUTER JOIN
                         membership.TypeFamilyInActiveStatusReason ON membership.MemberDetails.MemberStatusInactiveReasonTypeID = membership.TypeFamilyInActiveStatusReason.ID LEFT OUTER JOIN
                         membership.TypeTitle ON membership.MemberDetails.TitleTypeID = membership.TypeTitle.ID

WHERE membership.MemberDetails.MemberStatusTypeID = 1