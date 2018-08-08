





CREATE VIEW [membership].[uvwMemberBirthdaySMSTemplate]
AS
SELECT 
		'Anniversary' as EventName
		,[Mobile]
	  --,replace(convert(NVARCHAR, DateOfBirth, 106), ' ', '-')
	  --,Day(DateOfBirth) & '-' & month(DateOfBirth) & '-' & '2018'
	  ,replace(convert(NVARCHAR, DATEADD(YY, DATEPART(YYYY, GETDATE()) - DATEPART(YYYY,DateOfBirth), DateOfBirth), 106), ' ', '-') +  ' 06:00 AM' as BirthdaySMSScheduleDate
	  --,DateOfBirth
	  ,'CSIGSP' as SenderID
	  ,'Dear ' + [MemberFullName] +', Happy Birthday! I will surely bless you and make your descendants as numerous as the stars in the sky and as the sand on the seashore - Genesis 22:17. May our Lord Almighty continually bless you. Birthday wishes from CSI Good Samaritan Church, Pallikaranai.' AS Message
  FROM [membership].[uvwMemberBirthday]
  WHERE MONTH(DateOfBirth) in (7,8,9,10,11,12) and Mobile is not null
  --ORDER BY MONTH(DateOfBirth)