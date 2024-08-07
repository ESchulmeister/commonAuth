USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_Authenticate]    Script Date: 1/31/2022 8:55:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Elena Schulmeisetr
-- Create date: 6/23/2021
-- Description:	Common User Authenticate mechanism
-- =============================================
CREATE OR ALTER     PROCEDURE [dbo].[usp_Authenticate] 
	@applicationID		int, 
	@userName			varchar(50), 
	@password			varchar(8)

AS
BEGIN

	SET NOCOUNT ON;


	 -- encrypt sp generates a new hash every time, decrypt retruns the same value
	DECLARE @clearPassword			nvarchar(4000),
			@Cipher					varbinary(255),
			@userID					int,
			@apuID					int   --application ID


	SELECT @userID = au.[usrID],
			@Cipher = apuAccessKey,
			@apuID = au.apuID      
	FROM [dbo].[User] u 
		INNER JOIN [dbo].[AppUser] au ON au.usrID = u.usrID
		INNER JOIN [dbo].[Application] a ON a.appID = au.appID
	WHERE au.appID = @applicationID
	  AND u.usrLogin  =  @userName
	  AND u.usrActive = 1
	  AND au.apuActive = 1

	IF @userID IS NULL
	begin;
		THROW 500021, 'Authentication failure - invalid user account or application mapping', 1
		RETURN
	END

	if CHARINDEX('\', @userName) = 0         -- Not for Fully Qualified Domain Names
	begin
		EXEC [dbo].[usp_Decrypt] @Cipher = @Cipher, 
								@ClearText = @clearPassword  OUTPUT
		
		
		IF @clearPassword IS NULL OR  @clearPassword  != @password COLLATE Latin1_General_CS_AS     --case sensitivity  check
		begin;
			THROW 500022, 'Authentication failure - wrong password', 1
			RETURN
		end
		
	end

	if NOT EXISTS
	(
		SELECT 1 FROM [dbo].[AppUserPermission]
		WHERE [apuID] = @apuID
	)
	begin;
		THROW 500023, 'Authentication failure - no application permissions', 1
		RETURN
	end

	--user info
	SELECT u.usrID, 
		usrLogin, 
		usrLastName, 
		usrFirstName, 
		usrClock, 
		usrEmail, 
		usrActive, 
		usrStateID,
		usrCreatedBy, 
		usrCreatedDate,
		usrModifiedBy,
		usrModifiedDate
	FROM [dbo].[User] u 
		INNER JOIN [dbo].[AppUser] au ON au.usrID = u.usrID
		INNER JOIN [dbo].[Application] a ON a.appID = au.appID
	WHERE au.apuID = @apuID
	
	--permissions
	SELECT  aup.apID, ap.[permName],
			a.appID,a.appName, 
			aup.actID, act.[actName],
			aup.perMetadata
	FROM [dbo].[AppUser] au 
		INNER JOIN [dbo].[Application] a ON a.appID = au.appID
		INNER JOIN [dbo].[AppUserPermission] aup 
			ON aup.apuID = au.[apuID]
		   AND aup.perActive = 1
		INNER JOIN [dbo].[AppPermission] ap ON ap.apID = aup.apID
		INNER JOIN [dbo].[AccessType] act ON act.actID = aup.actID
	WHERE au.apuID = @apuID
	  AND a.appID = @applicationID

END
GO


