
CREATE VIEW [membership].[uvwMemberAnniversarySMSTemplate]
AS
SELECT 
		'Anniversary' as EventName
		,[Mobile]
	  --,replace(convert(NVARCHAR, AnniversaryDate, 106), ' ', '-')
	  --,Day(AnniversaryDate) & '-' & month(AnniversaryDate) & '-' & '2018'
	  ,replace(convert(NVARCHAR, DATEADD(YY, DATEPART(YYYY, GETDATE()) - DATEPART(YYYY,AnniversaryDate), AnniversaryDate), 106), ' ', '-') +  ' 06:00 AM' as AnniversarySMSScheduleDate
	  --,AnniversaryDate
	  ,'CSIGSP' as SenderID
	  ,'Dear ' + [MemberFullName] +', Happy Anniversary! I will surely bless you and make your descendants as numerous as the stars in the sky and as the sand on the seashore - Genesis 22:17. May our Lord Almighty continually bless you. Anniversary wishes from CSI Good Samaritan Church, Pallikaranai.' AS Message
  FROM [membership].[uvwMemberAnniversary]
  WHERE MONTH(AnniversaryDate) in (7,8,9,10,11,12) and Mobile is not null
  --ORDER BY MONTH(AnniversaryDate)