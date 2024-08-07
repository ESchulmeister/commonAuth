USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_execApplicationUser]    Script Date: 12/13/2021 3:12:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/21/21
-- Description:	Application user maintenance 
-- =============================================
CREATE OR ALTER   PROCEDURE [dbo].[usp_execApplicationUser] 
		@appID				int, 
		@usrPassword		varchar(8), 
		@usrID				int,
		@loggedOnUser		varchar(50)


AS
BEGIN

	SET NOCOUNT ON;

BEGIN TRY

	DECLARE	@Cipher varbinary(max), 
		@newID   int


		EXEC	[dbo].[usp_Encrypt]
			@ClearText =@usrPassword,
			@Cipher = @Cipher OUTPUT

		BEGIN TRANSACTION

		IF NOT EXISTS (
				SELECT 1 FROM dbo.AppUser
				WHERE [appID] = @appID
				  AND [usrID] = @usrID
		)
		begin
			INSERT INTO [dbo].[AppUser]
			(
				appID, 
				usrID, 
				apuActive, 
				apuAccessKey, 
				apuCreatedBy, 
				apuModifiedBy 
			)

			VALUES 
			(
				@appID, 
				@usrID, 
				1, 
				@Cipher, 
				@loggedOnUser, 
				@loggedOnUser
			)

			COMMIT TRANSACTION

			RETURN

		end

		UPDATE [dbo].[AppUser]
		SET [apuAccessKey]  = @Cipher, 
			[apuActive] = 1,
			apuModifiedBy = @loggedOnUser, 
			apuModifiedDate = GetDate()
		WHERE [appID] = @appID
		 AND [usrID] = @usrID


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

