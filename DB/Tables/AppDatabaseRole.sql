USE [UserDB]
GO

ALTER TABLE [dbo].[AppDatabaseRole] DROP CONSTRAINT [FK_AppDatabaseRoles_Applications]
GO

ALTER TABLE [dbo].[AppDatabaseRole] DROP CONSTRAINT [DF__AppDataba__adbMo__02FC7413]
GO

ALTER TABLE [dbo].[AppDatabaseRole] DROP CONSTRAINT [DF__AppDataba__adbCr__534D60F1]
GO

ALTER TABLE [dbo].[AppDatabaseRole] DROP CONSTRAINT [DF__AppDataba__adbAc__52593CB8]
GO

/****** Object:  Table [dbo].[AppDatabaseRole]    Script Date: 6/29/2021 11:19:03 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppDatabaseRole]') AND type in (N'U'))
DROP TABLE [dbo].[AppDatabaseRole]
GO

/****** Object:  Table [dbo].[AppDatabaseRole]    Script Date: 6/29/2021 11:19:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppDatabaseRole](
	[adbID] [int] IDENTITY(1,1) NOT NULL,
	[appID] [int] NULL,
	[adbName] [varchar](255) NULL,
	[adbRoleName] [varchar](255) NULL,
	[adbAccessKey] [varchar](255) NULL,
	[adbActive] [bit] NOT NULL,
	[adbCreatedBy] [varchar](50) NOT NULL,
	[adbCreatedDate] [datetime] NOT NULL,
	[adbModifiedBy] [varchar](50) NOT NULL,
	[adbModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AppDatabaseRoles] PRIMARY KEY CLUSTERED 
(
	[adbID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AppDatabaseRole] ADD  DEFAULT ((1)) FOR [adbActive]
GO

ALTER TABLE [dbo].[AppDatabaseRole] ADD  DEFAULT (getdate()) FOR [adbCreatedDate]
GO

ALTER TABLE [dbo].[AppDatabaseRole] ADD  DEFAULT (getdate()) FOR [adbModifiedDate]
GO

ALTER TABLE [dbo].[AppDatabaseRole]  WITH CHECK ADD  CONSTRAINT [FK_AppDatabaseRoles_Applications] FOREIGN KEY([appID])
REFERENCES [dbo].[Applications] ([appID])
GO

ALTER TABLE [dbo].[AppDatabaseRole] CHECK CONSTRAINT [FK_AppDatabaseRoles_Applications]
GO


