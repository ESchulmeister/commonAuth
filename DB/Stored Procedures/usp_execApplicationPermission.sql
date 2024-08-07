USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_execApplicationPermission]    Script Date: 12/13/2021 3:11:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/14/2021
-- Description:	App Permission Maintanance
-- =============================================
CREATE OR ALTER   PROCEDURE [dbo].[usp_execApplicationPermission]
		@appID			int = NULL,
		@apID			int = NULL,      -- permission id
		@permName		varchar(50), 
		@loggedOnUser	varchar(50) = 'admin', 
		@outID				INT OUTPUT 
AS
BEGIN
	 
	SET NOCOUNT ON;

	if @apID IS NULL
	begin
		if EXISTS
		(
			SELECT 1 
			FROM [dbo].[AppPermission]
			WHERE appID = @appID
			  AND permName = @permName
		)
		begin;
			THROW  500031, 'Cant Add Permission - duplicate name', 1
			RETURN
		end
	end
	else
	begin
		if ISNULL(@appID, 0) = 0
		begin
			SELECT @appID = appID
			FROM [dbo].[AppPermission]
			WHERE apID = @apID
		end

		if EXISTS
		(
			SELECT 1 
			FROM [dbo].[AppPermission]
			WHERE appID = @appID
			  AND permName = @permName
			   AND apID != @apID
		)
		begin;
			THROW  500031, 'Cant Update Permission - duplicate name', 1
			RETURN
		end
	end

BEGIN TRY
	BEGIN TRANSACTION

	if @apID IS NOT NULL
	begin
		UPDATE [dbo].[AppPermission]
		SET [permName] = @permName, 
			apModifiedBy = @loggedOnUser,
			apModifiedDate  = GetDate()
		WHERE [apID] = @apID	
		
		SELECT @outID = @apID
	end
	else
	begin
		IF NOT EXISTS     --app has no permissions defined
		(
			SELECT 1 FROM [dbo].[AppPermission]
			WHERE [appID] = @appID
			  AND [permName] = @permName
		)
		begin
			INSERT [dbo].[AppPermission] ([appID], [permName], [apCreatedBy],[apModifiedBy] )

			VALUES (@appID, @permName, @loggedOnUser, @loggedOnUser )

			SELECT @outID =SCOPE_IDENTITY()


		end
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

