USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_execUpdateUserApplicationPermission]    Script Date: 12/13/2021 3:13:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/26/21
-- Description:	Add new/Modify user's permission
-- =============================================
CREATE OR ALTER        PROCEDURE [dbo].[usp_execUpdateUserApplicationPermission]
		@perID				int,
		@actID				int, 
		@loggedOnUser		varchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	if @perID IS NULL
	begin;
		THROW 500028, 'Permission not detected', 1
		RETURN
	end

	BEGIN TRY

		BEGIN TRANSACTION

			UPDATE [dbo].[AppUserPermission]
			SET [actID] = @actID, 
				perModifiedBy = @loggedOnUser, 
				perModifiedDate = GetDate()
			WHERE [perID] = @perID

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
