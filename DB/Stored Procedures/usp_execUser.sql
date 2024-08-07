USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_execUser]    Script Date: 12/13/2021 3:13:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 7/16/21
-- Description:	User Maintanance
-- =============================================
CREATE OR ALTER     PROCEDURE [dbo].[usp_execUser]
	@usrID				int = null, 
	@usrLogin			varchar(50)= null, 
	@usrLastName		varchar(50)= null, 
	@usrFirstName		varchar(50)= null, 
	@usrClock			varchar(4)= null, 
	@usrEmail			varchar(255)= null, 
	@usrStateID         int = null,
	@loggedOnUser		varchar(50)  = 'admin', 
	@outID				INT OUTPUT 



AS
BEGIN
	
	SET NOCOUNT ON;

	IF @usrID IS NULL
	begin

		IF EXISTS
		(
			SELECT 1 FROM [dbo].[User]
			WHERE usrLogin = @usrLogin
		)
		begin;
			THROW 5000024, 'Cant add user - existing login', 1
			RETURN
		end

		IF EXISTS
		
		(
			SELECT 1 FROM [dbo].[User]
			WHERE usrEmail = @usrEmail
		)
		begin;
			THROW 5000024, 'Cant add user - existing email address', 1
			RETURN
		end
  end
  else
  begin

  		IF EXISTS
		(
			SELECT 1 FROM [dbo].[User]
			WHERE usrLogin = @usrLogin
			  AND [usrID] != @usrID
		)
		begin;
			THROW 5000024, 'Cant update user - existing login', 1
			RETURN
		end

  		IF EXISTS
		(
			SELECT 1 FROM [dbo].[User]
			WHERE usrEmail = @usrEmail
			  AND [usrID] != @usrID
		)
		begin;
			THROW 5000024, 'Cant update user - existing email address', 1
			RETURN
		end
  end




BEGIN TRY

	BEGIN TRANSACTION


	IF (@usrID IS NULL)
	begin
		

		INSERT [dbo].[User](
							usrLogin,
							usrLastName,
							usrFirstName,
							usrClock,
							usrEmail, 
							usrActive,
							usrStateID,
							usrCreatedBy, 
							usrCreatedDate, 
							usrModifiedBy
							)

		 VALUES  (
					@usrLogin,
					@usrLastName,
					@usrFirstName,
					@usrClock,
					@usrEmail, 
					1,
					@usrStateID,
					@loggedOnUser, 
					GetDate(), 
					@loggedOnUser
					)		

	    SET @outID = SCOPE_IDENTITY()

		COMMIT TRANSACTION 

		RETURN
	end
	


	UPDATE dbo.[User] 
	SET usrLogin  = ISNULL(@usrLogin, usrLogin), 
		usrFirstName  = ISNULL(@usrFirstName, usrFirstName), 
		usrLastName = ISNULL(@usrLastName, usrLastName),
		usrClock = ISNULL(@usrClock, usrClock),
		usrEmail = ISNULL(@usrEmail, usrEmail),
				usrStateID = ISNULL(@usrStateID, usrStateID),

		usrModifiedBy = @loggedOnUser, 
		usrModifiedDate = GetDate()

	WHERE usrID = @usrID

	SET @outID =  @usrID

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

