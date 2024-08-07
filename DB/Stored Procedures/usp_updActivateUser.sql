USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_updActivateUser]    Script Date: 12/13/2021 3:16:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 8/10/21
-- Description:	Activate User
-- =============================================
CREATE OR ALTER        PROCEDURE [dbo].[usp_updActivateUser]
	@usrID				int, 
	@loggedOnUser		varchar(50)



AS
BEGIN
	
	SET NOCOUNT ON;

BEGIN TRY


	BEGIN TRANSACTION

	UPDATE dbo.[User] 
	SET  usrActive = 1, 
		usrModifiedBy = @loggedOnUser, 
		usrModifiedDate = GetDate()
	WHERE usrID = @usrID

	COMMIT TRANSACTION


END TRY

BEGIN CATCH

	IF (@@ERROR <>0)
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

