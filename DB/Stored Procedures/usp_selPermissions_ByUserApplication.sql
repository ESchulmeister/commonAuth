USE [UserDB]
GO



/****** Object:  StoredProcedure [dbo].[usp_selPermissions_ByUserApplication]    Script Date: 8/20/2021 3:39:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/21/21
-- Description:	Permissions by application (ID)
-- =============================================
CREATE  OR ALTER   PROCEDURE [dbo].[usp_selPermissions_ByUserApplication] 
	@appID		int, 
	@usrID		int
AS
BEGIN

	SET NOCOUNT ON;


	SELECT  aup.perID,
			--aup.apuID,
			aup.apID, 
			ap.[permName],
			a.appID,
			a.appName, 
			aup.actID, 
			act.[actName],
			aup.perMetadata,
			au.usrID,
			a.appID
	FROM [dbo].[AppUser] au 
		INNER JOIN [dbo].[Application] a ON a.appID = au.appID
		INNER JOIN [dbo].[AppUserPermission] aup ON aup.apuID = au.[apuID]
		INNER JOIN [dbo].[AppPermission] ap ON ap.apID = aup.apID
		INNER JOIN [dbo].[AccessType] act ON act.actID = aup.actID
	WHERE ap.permActive = 1
	   AND aup.perActive = 1
		AND au.[usrID]  = @usrID
		AND au.appID = @appID
	 ORDER BY ap.[permName] ASC
		
		
END
GO


