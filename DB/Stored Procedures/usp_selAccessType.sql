USE [UserDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_selAccessType ]    Script Date: 12/13/2021 3:14:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Elena Schulmeister
-- Create date: 6/24/2021
-- Description:	List of Access Types - FK:AppUserSettings.actID
-- =============================================
CREATE OR ALTER   PROCEDURE [dbo].[usp_selAccessType ] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT actID, actName
	FROM [dbo].[AccessType]
END
GO

