USE [UserDB]
GO

ALTER TABLE [dbo].[AppPermission] DROP CONSTRAINT [FK_Permission_Application]
GO

ALTER TABLE [dbo].[AppPermission] DROP CONSTRAINT [DF_Permission_appID]
GO

/****** Object:  Table [dbo].[AppPermission]    Script Date: 6/30/2021 8:10:23 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppPermission]') AND type in (N'U'))
DROP TABLE [dbo].[AppPermission]
GO

/****** Object:  Table [dbo].[AppPermission]    Script Date: 6/30/2021 8:10:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppPermission](
	[apID] [int] IDENTITY(1,1) NOT NULL,
	[appID] [int] NOT NULL,
	[permName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[apID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AppPermission] ADD  CONSTRAINT [DF_Permission_appID]  DEFAULT ((1)) FOR [appID]
GO

ALTER TABLE [dbo].[AppPermission]  WITH CHECK ADD  CONSTRAINT [FK_Permission_Application] FOREIGN KEY([appID])
REFERENCES [dbo].[Application] ([appID])
GO

ALTER TABLE [dbo].[AppPermission] CHECK CONSTRAINT [FK_Permission_Application]
GO


