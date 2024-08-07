USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_delApplication]    Script Date: 12/13/2021 3:08:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/12/2021
-- 8/6/21 
-- Description: Delete Application - reset Active Flag
-- =============================================
CREATE OR ALTER   PROCEDURE [dbo].[usp_delApplication]
	@appID			INT , 
	@loggedOnUser	varchar(50)

AS

BEGIN
	
	SET NOCOUNT ON;

	DECLARe @apID INT


	IF EXISTS (
	
			SELECT 1 FROM [dbo].[AppUser]
			WHERE appID = @appID
	)

	begin;

			THROW 500025, 'Cant Delete Application - there are Linked Users', 1
			RETURN


	end


BEGIN TRY

	IF EXISTS 
	(
		SELECT 1 FROM [dbo].[AppUserPermission] apu
			INNER JOIN [dbo].[AppUser]au 
				ON au.apuID = apu.apuID
			   AND au.appID = @appID
	)

	begin;
			THROW 500029, 'Cannot Delete the Application - Permissions assigned to Users', 1
			RETURN
	end 

   BEGIN TRANSACTION

   IF EXISTS 
   (
		SELECT 1 FROM [dbo].[AppPermission]
		WHERE [appID] = @appID
		 AND [permActive] = 1 
	)

	begin
		
	   UPDATE [dbo].[AppPermission]
	   SET [permActive] = 0, 
			permModifiedBy = @loggedOnUser, 
			permModifiedDate  = GetDate()
	   WHERE appID  = @appID

   end 

   UPDATE  [dbo].[Application]
   SET [appActive] = 0, 
		appModifiedBy = @loggedOnUser, 
		appModifiedDate =  GetDate()
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


    RAISERROR (@ErrorMessage,  
               @ErrorSeverity, 
               @ErrorState  
               );
END CATCH


END
GO

