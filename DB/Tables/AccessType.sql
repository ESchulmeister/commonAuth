USE [UserDB]
GO

/****** Object:  Table [dbo].[AccessType]    Script Date: 6/29/2021 11:16:58 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccessType]') AND type in (N'U'))
DROP TABLE [dbo].[AccessType]
GO

/****** Object:  Table [dbo].[AccessType]    Script Date: 6/29/2021 11:16:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AccessType](
	[actID] [int] NOT NULL,
	[actName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AccessTypes] PRIMARY KEY CLUSTERED 
(
	[actID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


