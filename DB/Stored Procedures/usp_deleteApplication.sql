USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_deleteApplication]    Script Date: 12/13/2021 3:09:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 9/24/2021
-- Description:	Delete application - remove corresp rows
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[usp_deleteApplication]
	@appID		int
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY

	DECLARE @error_message	nvarchar(255)

	DECLARE @TMP  TABLE   (ID	 INT)
	
	INSERT INTO @Tmp   (ID)
	 
	(	
		SELECT apuID
		FROM  [dbo].[AppUser]
		WHERE appID = @appID

	)

	BEGIN TRAN

	SET @error_message = 'Error deleting [dbo].[AppUser]'
	DELETE 
	FROM  [dbo].[AppUser]
	WHERE appID = @appID


	SET @error_message = 'Error deleting [dbo].[AppUserPermission]'
	DELETE 
	FROM [dbo].[AppUserPermission]
	WHERE [apID] =  @appID
	  AND [apuID] IN (SELECT ID FROM @Tmp)

	
	SET @error_message = 'Error deleting [dbo].[AppPermission]'
	DELETE
	FROM [dbo].[AppPermission]
	WHERE appID  = @appID


	SET @error_message = 'Error deleting [dbo].[Application]'
   	DELETE
	FROM [dbo].[Application]
	WHERE appID  = @appID


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
        @ErrorMessage = @error_message + ': ' + ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();


    RAISERROR (@ErrorMessage,  
               @ErrorSeverity, 
               @ErrorState  
               );
END CATCH


END

GO

