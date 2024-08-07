USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_Decrypt]    Script Date: 12/13/2021 3:07:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 6/21/2021
-- Description:	Decrypt a string
-- =============================================
CREATE OR ALTER PROC [dbo].[usp_Decrypt]
(
	@Cipher		varbinary(max),
	@ClearText	nvarchar(4000) = NULL OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

	OPEN SYMMETRIC KEY DtbMainUserKey DECRYPTION BY CERTIFICATE DtbUserCertificate

	SELECT @ClearText = DECRYPTBYKEY(@Cipher)
 
	CLOSE SYMMETRIC KEY DtbMainUserKey
END
GO

