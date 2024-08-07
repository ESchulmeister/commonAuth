USE [UserDB]
GO

ALTER TABLE [dbo].[AppUser] DROP CONSTRAINT [FK_ApplicationUser_Users]
GO

ALTER TABLE [dbo].[AppUser] DROP CONSTRAINT [FK_ApplicationUser_Applications]
GO

ALTER TABLE [dbo].[AppUser] DROP CONSTRAINT [DF__AppUsers__apuMod__71D1E811]
GO

ALTER TABLE [dbo].[AppUser] DROP CONSTRAINT [DF__AppUsers__apuCre__70DDC3D8]
GO

ALTER TABLE [dbo].[AppUser] DROP CONSTRAINT [DF__AppUsers__apuAct__6FE99F9F]
GO

/****** Object:  Table [dbo].[AppUser]    Script Date: 6/29/2021 11:21:35 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppUser]') AND type in (N'U'))
DROP TABLE [dbo].[AppUser]
GO

/****** Object:  Table [dbo].[AppUser]    Script Date: 6/29/2021 11:21:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppUser](
	[apuID] [int] IDENTITY(1,1) NOT NULL,
	[appID] [int] NOT NULL,
	[usrID] [int] NOT NULL,
	[apuActive] [bit] NOT NULL,
	[apuAccessKey] [varbinary](max) NULL,
	[apuCreatedBy] [varchar](50) NOT NULL,
	[apuCreatedDate] [datetime] NOT NULL,
	[apuModifiedBy] [varchar](50) NOT NULL,
	[apuModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ApplicationUser] PRIMARY KEY CLUSTERED 
(
	[apuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF__AppUsers__apuAct__6FE99F9F]  DEFAULT ((1)) FOR [apuActive]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF__AppUsers__apuCre__70DDC3D8]  DEFAULT (getdate()) FOR [apuCreatedDate]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF__AppUsers__apuMod__71D1E811]  DEFAULT (getdate()) FOR [apuModifiedDate]
GO

ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationUser_Applications] FOREIGN KEY([appID])
REFERENCES [dbo].[Application] ([appID])
GO

ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [FK_ApplicationUser_Applications]
GO

ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationUser_Users] FOREIGN KEY([usrID])
REFERENCES [dbo].[Users] ([usrID])
GO

ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [FK_ApplicationUser_Users]
GO


