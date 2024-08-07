USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_execInsertUserApplicationPermission]    Script Date: 12/13/2021 3:12:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/26/21
-- Description:	Add new/Modify user's permission
-- =============================================
CREATE OR ALTER       PROCEDURE [dbo].[usp_execInsertUserApplicationPermission]
		@usrID				int, 
		@appID				int,
		@apID				int,
		@actID				int, 
		@loggedOnUser		varchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @apuID int, @perID int, @perActive bit


	SELECT @apuID = apuID
	FROM [dbo].[AppUser] au
	WHERE au.usrID = @usrID
	  AND au.appID = @appID

	-- check if User is set up for the Application
	IF (@apuID IS NULL)
	begin;

		THROW 500026, 'The User has not been set up for the selected Application', 1
		RETURN
	end

	-- check if the row already exists to determine INSERT vs. UPDATE
	SELECT @perID = apu.[perID],
			@perActive = apu.perActive
	FROM [dbo].[AppUserPermission] apu
	WHERE apu.[apuID] = @apuID
	  AND apu.[apID] = @apID

	if @perID IS NOT NULL AND IsNull(@perActive, 0) = 1
	begin;
		THROW 500027, 'Selected permission has already been set up for this User', 1
		RETURN
	end

	BEGIN TRY

		BEGIN TRANSACTION

		if @perID IS NULL
		begin
			INSERT [dbo].[AppUserPermission] (
				apuID,
				apID,
				actID, 
				perActive, 
				perCreatedBy,
				perModifiedBy,
				perCreatedDate

			)

			VALUES 
			(
				@apuID,
				@apID,
				@actID,
				1,
				@loggedOnUser,
				@loggedOnUser,
				GetDate()
			)
		end
		else
		begin
			UPDATE [dbo].[AppUserPermission]
			SET perActive = 1,
				perModifiedBy = @loggedOnUser,
				perModifiedDate = GetDate()
			WHERE perID = @perID
		end

		COMMIT TRANSACTION 

	END TRY

	BEGIN CATCH

		IF (@@TRANCOUNT != 0)
		begin
			ROLLBACK TRAN
		end

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();


		RAISERROR (@ErrorMessage,  
				   @ErrorSeverity, 
				   @ErrorState  
				   );
	END CATCH


END
GO

