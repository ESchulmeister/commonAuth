USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_selAvailablePermissions_ByUserApplication]    Script Date: 12/13/2021 3:15:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 8/3/21
-- Description:	Available Permissions by application (ID) & user (ID)
-- =============================================
CREATE OR ALTER        PROCEDURE [dbo].[usp_selAvailablePermissions_ByUserApplication] 
	@appID		int, 
	@usrID		int
AS
BEGIN

	SET NOCOUNT ON;


	SELECT  ap.apID, 
			ap.[permName],
			a.appID,
			a.appName, 
			au.usrID,
			a.appID
	FROM [dbo].[AppUser] au 
		INNER JOIN [dbo].[Application] a 
			ON a.appID = au.appID
		   AND a.appActive = 1
		INNER JOIN [dbo].[AppPermission] ap ON ap.appID = a.appID
	WHERE au.usrID = @usrID
	  AND au.appID = @appID
	  AND NOT EXISTS
		(
			SELECT 1 FROM [dbo].[AppUserPermission] aupInner
				INNER JOIN [dbo].[AppUser] auInner 
					ON auInner.apuID = aupInner.apuID
				   AND auInner.appID = @appID
				   AND auInner.usrID = @usrID
			WHERE aupInner.apID = ap.apID
			  AND aupInner.perActive = 1
		)
	 ORDER BY ap.[permName] ASC
		
		
END
GO

