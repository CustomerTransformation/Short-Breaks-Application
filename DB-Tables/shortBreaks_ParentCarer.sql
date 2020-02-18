USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  Table [dbo].[shortBreaks_ParentCarer]    Script Date: 18/02/2020 10:36:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[shortBreaks_ParentCarer](
	[ID_ParentCarer] [int] IDENTITY(1,1) NOT NULL,
	[reference] [varchar](15) NULL,
	[title] [varchar](10) NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[dateOfBirth] [date] NULL,
	[email] [varchar](255) NULL,
	[phoneNum] [varchar](50) NULL,
	[mobile] [varchar](50) NULL,
	[flat] [varchar](50) NULL,
	[house] [varchar](50) NULL,
	[road] [varchar](50) NULL,
	[town] [varchar](50) NULL,
	[postCode] [varchar](10) NULL,
	[uprn] [varchar](10) NULL,
	[eligable] [varchar](20) NULL,
	[dateSubmitted] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[createdDate] [datetime] NULL,
	[modifiedBy] [varchar](50) NULL,
	[modifiedDate] [datetime] NULL,
	[previously] [varchar](5) NULL,
	[stillHave] [varchar](5) NULL,
	[forYear] [varchar](500) NULL,
	[organisation] [varchar](80) NULL
) ON [PRIMARY]
GO


