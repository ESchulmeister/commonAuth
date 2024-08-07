USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_selApplications ]    Script Date: 12/13/2021 3:14:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 6/24/2021
--				 7/13/2021 - permissions
--              8/10/21 - @Active flag
-- Description:	Application By ID
--			FK:AppUserSettings.aupID
-- =============================================
CREATE OR ALTER      PROCEDURE [dbo].[usp_selApplications ] 
	@isActive		bit  = 1
AS
BEGIN
	SET NOCOUNT ON;

	SELECT appID,
		appName,
		appFlags, 
		appActive,
		appCreatedBy, 
		appCreatedDate,
		appModifiedBy, 
		appModifiedDate
	FROM [dbo].[Application]
	WHERE appActive = IsNull(@isActive , 0)	
	
	ORDER BY appName ASC


END

GO

