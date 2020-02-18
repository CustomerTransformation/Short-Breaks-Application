USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  Table [dbo].[shortBreaks_FinancialYear]    Script Date: 18/02/2020 10:35:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[shortBreaks_FinancialYear](
	[ID_FinYear] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](25) NULL,
	[standardAmount] [decimal](10, 2) NULL,
	[startDate] [date] NULL,
	[endDate] [date] NULL,
	[current] [bit] NULL,
	[createdBy] [varchar](50) NULL,
	[createdDate] [datetime] NULL,
	[modifiedBy] [varchar](50) NULL,
	[modifiedDate] [datetime] NULL
) ON [PRIMARY]
GO


