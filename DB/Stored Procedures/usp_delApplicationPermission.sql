USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_delUserApplicationPermission]    Script Date: 12/13/2021 3:10:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/28/21
-- Description: [dbo].[AppUserPermission] activeFlag
-- =============================================
CREATE OR ALTER      PROCEDURE [dbo].[usp_delUserApplicationPermission]
		@perID			 int, 
		@loggedOnUser	varchar(50)

AS

BEGIN
	
	SET NOCOUNT ON;

	
BEGIN TRY


	BEGIN TRANSACTION
		
	UPDATE [dbo].[AppUserPermission]
	SET  perActive = 0, 
		perModifiedBy= @loggedOnUser, 
		perModifiedDate = Getdate()
	WHERE perID = @perID

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

