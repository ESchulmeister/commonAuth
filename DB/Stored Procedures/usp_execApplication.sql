USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_execApplication]    Script Date: 12/13/2021 3:10:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/12/2021
-- upd - 8/4/2021 -   dupe  Name check
-- 12/9/2021 - @outID param
-- Description: Application Add/Edit 
-- =============================================
CREATE OR ALTER   PROCEDURE [dbo].[usp_execApplication]
	@appID			INT = null, 
	@appName		varchar(255), 
	@loggedOnUser	varchar(50)  = 'admin', 
	@outID			INT OUTPUT 

AS
BEGIN
	
	SET NOCOUNT ON;

	if @appID IS NULL
	begin
		if EXISTS
		(
			SELECT 1
			FROM [dbo].[Application]
			WHERE appName = @appName			
		)
		begin;
			THROW  500030, 'Cant Add application - duplicate name', 1
			RETURN
		end
	end
	else
	begin
		if EXISTS
		(
			SELECT 1
			FROM [dbo].[Application]
			WHERE appName = @appName			
			  AND appID != @appID
		)
		begin;
			THROW  500030, 'Cant Update application - duplicate name', 1
			RETURN
		end
	end


BEGIN TRY

	BEGIN TRANSACTION

	IF (@appID  IS NULL)

	begin

		INSERT INTO [dbo].[Application]
				   (
						[appName]
					   ,[appActive]
					   ,[appCreatedBy]
					   ,[appModifiedBy]
				  )
			 VALUES
				   (
						@appName
						, 1
						,@loggedOnUser
						,@loggedOnUser
					)

		COMMIT TRANSACTION 

		SELECT @outID = SCOPE_IDENTITY();

		RETURN

	end
		
   UPDATE [dbo].[Application]
   SET [appName] = @appName, 
		appModifiedBy = @loggedOnUser,
		[appModifiedDate] = GetDate()
   WHERE appID = @appID

   SELECT @outID = @appID

   COMMIT TRANSACTION

END TRY

BEGIN CATCH

	IF (XACT_STATE()) = -1
	ROLLBACK TRANSACTION
 
-- Transaction committable
    IF (XACT_STATE()) = 1
      COMMIT TRANSACTION

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

