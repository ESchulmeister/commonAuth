USE [UserDB]
GO

ALTER TABLE [dbo].[AppUserPermission] DROP CONSTRAINT [FK_AppUserPermissions_AppUsers]
GO

ALTER TABLE [dbo].[AppUserPermission] DROP CONSTRAINT [FK_AppUserPermissions_AppPermissions]
GO

ALTER TABLE [dbo].[AppUserPermission] DROP CONSTRAINT [FK_AppUserPermissions_AccessTypes]
GO

ALTER TABLE [dbo].[AppUserPermission] DROP CONSTRAINT [DF__AppUserPe__perMo__7B5B524B]
GO

ALTER TABLE [dbo].[AppUserPermission] DROP CONSTRAINT [DF_AppUserPermissions_perActive]
GO

/****** Object:  Table [dbo].[AppUserPermission]    Script Date: 6/30/2021 8:09:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppUserPermission]') AND type in (N'U'))
DROP TABLE [dbo].[AppUserPermission]
GO

/****** Object:  Table [dbo].[AppUserPermission]    Script Date: 6/30/2021 8:09:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppUserPermission](
	[perID] [int] IDENTITY(1,1) NOT NULL,
	[apuID] [int] NULL,
	[apID] [int] NOT NULL,
	[actID] [int] NULL,
	[perMetadata] [varchar](max) NULL,
	[perActive] [bit] NOT NULL,
	[perCreatedBy] [varchar](50) NOT NULL,
	[perCreatedDate] [datetime] NULL,
	[perModifiedBy] [varchar](50) NOT NULL,
	[perModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AppUserPermissions] PRIMARY KEY CLUSTERED 
(
	[perID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[AppUserPermission] ADD  CONSTRAINT [DF_AppUserPermissions_perActive]  DEFAULT ((1)) FOR [perActive]
GO

ALTER TABLE [dbo].[AppUserPermission] ADD  CONSTRAINT [DF__AppUserPe__perMo__7B5B524B]  DEFAULT (getdate()) FOR [perModifiedDate]
GO

ALTER TABLE [dbo].[AppUserPermission]  WITH CHECK ADD  CONSTRAINT [FK_AppUserPermissions_AccessTypes] FOREIGN KEY([actID])
REFERENCES [dbo].[AccessType] ([actID])
GO

ALTER TABLE [dbo].[AppUserPermission] CHECK CONSTRAINT [FK_AppUserPermissions_AccessTypes]
GO

ALTER TABLE [dbo].[AppUserPermission]  WITH CHECK ADD  CONSTRAINT [FK_AppUserPermissions_AppPermissions] FOREIGN KEY([apID])
REFERENCES [dbo].[AppPermission] ([apID])
GO

ALTER TABLE [dbo].[AppUserPermission] CHECK CONSTRAINT [FK_AppUserPermissions_AppPermissions]
GO

ALTER TABLE [dbo].[AppUserPermission]  WITH CHECK ADD  CONSTRAINT [FK_AppUserPermissions_AppUsers] FOREIGN KEY([apuID])
REFERENCES [dbo].[AppUser] ([apuID])
GO

ALTER TABLE [dbo].[AppUserPermission] CHECK CONSTRAINT [FK_AppUserPermissions_AppUsers]
GO


