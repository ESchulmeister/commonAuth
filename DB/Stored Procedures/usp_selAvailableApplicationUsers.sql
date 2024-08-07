USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_selAvailableApplicationUsers]    Script Date: 12/13/2021 3:14:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/28/21
-- Description:	Available app users
-- =============================================
CREATE OR ALTER     PROCEDURE [dbo].[usp_selAvailableApplicationUsers]
		@appID     INT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT usrID, 
			usrLogin,
			usrLastName,
			usrFirstName,
			usrClock,
			usrEmail,
			usrActive,
			usrCreatedBy,
			usrCreatedDate,
			usrModifiedBy,
			usrModifiedDate
	FROM dbo.[User]  
	WHERE usrActive = 1
	AND  usrID NOT  IN
	 (
			SELECT usrID FROM [dbo].[AppUser]
			WHERE [appID]  = @appID

	  )


	ORDER BY usrLastName ASC, usrFirstName ASC
    
END
GO

