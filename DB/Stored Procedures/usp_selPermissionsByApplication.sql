USE [UserDB]
GO


/****** Object:  StoredProcedure [dbo].[usp_selPermissionsByApplication]    Script Date: 8/20/2021 3:39:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/13/2021
--				8/10/21 - @isActive 
-- Description:	Permissions by application (ID)
-- =============================================
CREATE  OR ALTER PROCEDURE [dbo].[usp_selPermissionsByApplication] 
	@appID			int, 
	@isActive		bit  = 1

AS
BEGIN

	SET NOCOUNT ON;

	SELECT  ap.apID,
			ap.[permName],
			a.appID,
			a.appName
	FROM [dbo].[AppPermission] ap
		INNER JOIN [dbo].[Application] a ON a.appID = ap.appID
	WHERE a.appID = @appID
	 AND ap.permActive = IsNull(@isActive, 0)
	 ORDER BY ap.[permName] ASC
		
		
END
GO


