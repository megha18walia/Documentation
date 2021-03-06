
/****** Object:  Table [dbo].[Restaurant]    Script Date: 10/7/2018 12:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurant](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Cuisine] [int] NOT NULL,
	[Name] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK_Restaurant] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Restaurant] ON 
GO
INSERT [dbo].[Restaurant] ([ID], [Cuisine], [Name]) VALUES (1, 0, N'Eleven to Eleven')
GO
INSERT [dbo].[Restaurant] ([ID], [Cuisine], [Name]) VALUES (2, 1, N'Dominos')
GO
INSERT [dbo].[Restaurant] ([ID], [Cuisine], [Name]) VALUES (3, 1, N'Pizza Hut')
GO
SET IDENTITY_INSERT [dbo].[Restaurant] OFF
GO
