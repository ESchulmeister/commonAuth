USE [UserDB]
GO

ALTER TABLE [dbo].[Application] DROP CONSTRAINT [DF__Applicati__appMo__6B24EA82]
GO

ALTER TABLE [dbo].[Application] DROP CONSTRAINT [DF__Applicati__appCr__5070F446]
GO

ALTER TABLE [dbo].[Application] DROP CONSTRAINT [DF__Applicati__appAc__4F7CD00D]
GO

/****** Object:  Table [dbo].[Application]    Script Date: 6/29/2021 11:20:05 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Application]') AND type in (N'U'))
DROP TABLE [dbo].[Application]
GO

/****** Object:  Table [dbo].[Application]    Script Date: 6/29/2021 11:20:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Application](
	[appID] [int] IDENTITY(1,1) NOT NULL,
	[appName] [varchar](255) NOT NULL,
	[appFlags] [int] NULL,
	[appActive] [bit] NOT NULL,
	[appCreatedBy] [varchar](50) NOT NULL,
	[appCreatedDate] [datetime] NOT NULL,
	[appModifiedBy] [varchar](50) NOT NULL,
	[appModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[appID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Application] ADD  DEFAULT ((1)) FOR [appActive]
GO

ALTER TABLE [dbo].[Application] ADD  DEFAULT (getdate()) FOR [appCreatedDate]
GO

ALTER TABLE [dbo].[Application] ADD  DEFAULT (getdate()) FOR [appModifiedDate]
GO


