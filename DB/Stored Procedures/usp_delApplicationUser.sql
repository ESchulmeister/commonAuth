USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_delApplicationUser]    Script Date: 12/13/2021 3:09:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/16/2021
-- Description:	Delete application  user - remove from application
-- =============================================
CREATE OR ALTER   PROCEDURE [dbo].[usp_delApplicationUser]
	@appID		int,
	@usrID		int, 
	@loggedOnUser	varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @apuID INT

	SELECT @apuID = apuID 
	FROM [dbo].[AppUser]
	WHERE usrID = @usrID

BEGIN TRY


	BEGIN TRANSACTION

	
	UPDATE [dbo].[AppUser]
	SET [apuActive] = 0, 
		apuModifiedBy = @loggedonUser, 
		apuModifiedDate = GetDate()
	WHERE [usrID] = @usrID
	 AND [appID] = appID

	--'delete' users permissions	

	UPDATE [dbo].[AppUserPermission]
		SET [perActive] = 0,
			perModifiedBy = @loggedOnUser, 
			perModifiedDate = GetDate()
		WHERE [apuID] = @apuID
	
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

