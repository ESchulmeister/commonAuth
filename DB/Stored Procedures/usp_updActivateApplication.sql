USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_updActivateApplication]    Script Date: 12/13/2021 3:15:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 8/10/2021
-- Description: Application activation
-- =============================================
CREATE OR ALTER       PROCEDURE [dbo].[usp_updActivateApplication]
	@appID			INT , 
	@loggedOnUser	varchar(50)

AS
BEGIN
	
	SET NOCOUNT ON;


BEGIN TRY

	BEGIN TRANSACTION
	
   IF EXISTS 
   (
		SELECT 1 FROM  [dbo].[AppPermission]
		WHERE appID = @appID
   )

   begin

		UPDATE  [dbo].[AppPermission]
		SET apActive= 1, 
			apModifiedBy  = @loggedOnUser, 
			apModifiedDate = GetDate()
		WHERE appID = @appID

   end

		
   UPDATE [dbo].[Application]
   SET appActive= 1, 
		appModifiedBy = @loggedOnUser,
		[appModifiedDate] = GetDate()
   WHERE appID = @appID


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


    RAISERROR (@ErrorMessage,   @ErrorSeverity,   @ErrorState );

END CATCH


END
GO

