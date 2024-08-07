USE [UserDB]
GO

ALTER TABLE [dbo].[AppUserSetting] DROP CONSTRAINT [FK_AppUserSettings_ContentType]
GO

ALTER TABLE [dbo].[AppUserSetting] DROP CONSTRAINT [FK_AppUserSettings_AppUsers]
GO

ALTER TABLE [dbo].[AppUserSetting] DROP CONSTRAINT [DF__AppUserSe__setMo__02084FDA]
GO

ALTER TABLE [dbo].[AppUserSetting] DROP CONSTRAINT [DF_AppUserSettings_setActive]
GO

/****** Object:  Table [dbo].[AppUserSetting]    Script Date: 6/29/2021 11:22:18 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppUserSetting]') AND type in (N'U'))
DROP TABLE [dbo].[AppUserSetting]
GO

/****** Object:  Table [dbo].[AppUserSetting]    Script Date: 6/29/2021 11:22:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppUserSetting](
	[setID] [int] IDENTITY(1,1) NOT NULL,
	[apuID] [int] NULL,
	[setName] [varchar](255) NULL,
	[setValue] [varchar](max) NULL,
	[setContentTypeID] [int] NULL,
	[setActive] [bit] NOT NULL,
	[setCreatedBy] [varchar](50) NULL,
	[setCreatedDate] [datetime] NULL,
	[setModifiedBy] [varchar](50) NOT NULL,
	[setModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AppUserSettings] PRIMARY KEY CLUSTERED 
(
	[setID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[AppUserSetting] ADD  CONSTRAINT [DF_AppUserSettings_setActive]  DEFAULT ((1)) FOR [setActive]
GO

ALTER TABLE [dbo].[AppUserSetting] ADD  DEFAULT (getdate()) FOR [setModifiedDate]
GO

ALTER TABLE [dbo].[AppUserSetting]  WITH CHECK ADD  CONSTRAINT [FK_AppUserSettings_AppUsers] FOREIGN KEY([apuID])
REFERENCES [dbo].[AppUser] ([apuID])
GO

ALTER TABLE [dbo].[AppUserSetting] CHECK CONSTRAINT [FK_AppUserSettings_AppUsers]
GO

ALTER TABLE [dbo].[AppUserSetting]  WITH CHECK ADD  CONSTRAINT [FK_AppUserSettings_ContentType] FOREIGN KEY([setContentTypeID])
REFERENCES [dbo].[ContentType] ([cntID])
GO

ALTER TABLE [dbo].[AppUserSetting] CHECK CONSTRAINT [FK_AppUserSettings_ContentType]
GO


