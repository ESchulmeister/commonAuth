USE [UserDB]
GO

ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF__Users__usrModifi__6C190EBB]
GO

ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF__Users__usrCreate__49C3F6B7]
GO

ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF__Users__usrActive__48CFD27E]
GO

/****** Object:  Table [dbo].[User]    Script Date: 6/29/2021 11:24:50 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
DROP TABLE [dbo].[User]
GO

/****** Object:  Table [dbo].[User]    Script Date: 6/29/2021 11:24:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[User](
	[usrID] [int] IDENTITY(1,1) NOT NULL,
	[usrLogin] [varchar](50) NOT NULL,
	[usrLastName] [varchar](255) NOT NULL,
	[usrFirstName] [varchar](255) NOT NULL,
	[usrClock] [varchar](50) NULL,
	[usrEmail] [varchar](255) NULL,
	[usrActive] [bit] NOT NULL,
	[usrCreatedBy] [varchar](50) NULL,
	[usrCreatedDate] [datetime] NOT NULL,
	[usrModifiedBy] [varchar](50) NOT NULL,
	[usrModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[usrID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_UsrLogin] UNIQUE NONCLUSTERED 
(
	[usrLogin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__Users__usrActive__48CFD27E]  DEFAULT ((1)) FOR [usrActive]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__Users__usrCreate__49C3F6B7]  DEFAULT (getdate()) FOR [usrCreatedDate]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__Users__usrModifi__6C190EBB]  DEFAULT (getdate()) FOR [usrModifiedDate]
GO


