USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_Encrypt]    Script Date: 12/13/2021 3:10:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 6/21/2021
-- Description:	Decrypt a string
-- =============================================
CREATE OR ALTER PROC [dbo].[usp_Encrypt]
(
	@ClearText	 nvarchar(4000),
	@Cipher		varbinary(max) = NULL OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

	OPEN SYMMETRIC KEY DtbMainUserKey DECRYPTION BY CERTIFICATE DtbUserCertificate

	SELECT @Cipher = ENCRYPTBYKEY(Key_GUID('DtbMainUserKey'), @ClearText)
 
	CLOSE SYMMETRIC KEY DtbMainUserKey
END
GO

