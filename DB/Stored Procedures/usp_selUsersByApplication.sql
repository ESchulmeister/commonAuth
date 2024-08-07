USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_selUsersByApplication]    Script Date: 12/13/2021 3:15:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Elena Schulmeisetr
-- Create date: 7/7/2021
--8/6/21 - hasPermissionsToAdd
-- Description:	Web Auth Manager
-- =============================================
CREATE OR ALTER     PROCEDURE [dbo].[usp_selUsersByApplication] 
	@appID		int
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @appPerCount int

	--permissions per application
	SELECT @appPerCount = Count(*)
	FROM [dbo].[AppPermission]
	WHERE [appID] = @appID


	;WITH cte_UserPermission(usrID, perCount)
	AS
	(
		SELECT au.usrID, Count(aup.perID)
		FROM [dbo].[AppUser] au 
			INNER JOIN [dbo].[Application] a 
				ON a.appID = au.appID
			   AND a.appActive = 1
			INNER JOIN [dbo].[AppPermission] ap 
				ON ap.appID = a.appID
			LEFT JOIN [dbo].[AppUserPermission] aup
				ON aup.apID = ap.apID
			   AND aup.apuID = au.apuID
		WHERE au.appID = @appID
		GROUP BY au.usrID
	)
	SELECT u.usrID,
		au.appID,
		au.apuAccessKey,
		usrLogin, 
		usrLastName, 
		usrFirstName, 
		--usrClock, 
		--usrEmail, 
		--usrActive, 
		--usrCreatedBy, 
		--usrCreatedDate,
		--usrModifiedBy,
		--usrModifiedDate,
		Case
			WHEN cte.perCount = @appPerCount THEN Cast(0 as bit)
			ELSE Cast(1 as bit)
		end as hasPermissionsToAdd
	FROM [dbo].[User] u
		INNER JOIN [dbo].[AppUser] au ON au.usrID = u.usrID
		INNER JOIN cte_UserPermission cte ON cte.usrID = u.usrID
	WHERE au.appID = @appID
	  AND u.usrActive = 1
	  AND au.apuActive = 1
END
GO

