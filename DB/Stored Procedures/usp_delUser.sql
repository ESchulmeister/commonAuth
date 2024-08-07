USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_delUser]    Script Date: 12/13/2021 3:10:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/16/2021
-- 8/6/21 - update other (appUser/permission) flags
-- Description:	Delete user - reset active flag @ appUser
-- =============================================
CREATE OR ALTER   PROCEDURE [dbo].[usp_delUser]
	@usrID		int, 
	@loggedOnUser	varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

BEGIN TRY

	BEGIN TRANSACTION

	DECLARE @apuID INT, @perID int

	SELECT @apuID = [apuID]
	FROM [dbo].[AppUser]
	WHERE [usrID] = @usrID

	--reset permission flags

	if (@apuID is NOT NULL)
	begin

		UPDATE [dbo].[AppUser]
		SET [apuActive] = 0, 
			apuModifiedDate = GetDate(), 
			apuModifiedBy = @loggedOnUser
		WHERE [usrID] = @usrID

		
		UPDATE dbo.[AppUserPermission]
		SET [perActive] = 0, 
			[perModifiedBy] = @loggedOnUser, 
			[perModifiedDate] = GetDate()
		WHERE [apuID] = @apuID

		
	end
	


	UPDATE [dbo].[User]
	SET [usrActive] = 0, 
		[usrModifiedBy] = @loggedOnUser, 
		usrModifiedDate = GetDate()
	WHERE [usrID] = @usrID

	
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

