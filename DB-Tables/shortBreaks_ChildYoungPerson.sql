USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  Table [dbo].[shortBreaks_ChildYoungPerson]    Script Date: 18/02/2020 10:35:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[shortBreaks_ChildYoungPerson](
	[ID_ChildYoungPer] [int] IDENTITY(1,1) NOT NULL,
	[ParentCarerRef] [varchar](15) NOT NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[DoB] [date] NULL,
	[attendEducation] [varchar](5) NULL,
	[EHCplan] [varchar](5) NULL,
	[nameOfSchool] [varchar](250) NULL,
	[eligible] [varchar](10) NULL,
	[createdDate] [datetime] NULL,
	[modifiedBy] [varchar](50) NULL,
	[modifiedDate] [datetime] NULL,
	[eligibleChecked] [varchar](5) NULL,
	[addedMonitor] [varchar](5) NULL,
	[finYear] [varchar](50) NULL,
	[remove] [varchar](5) NULL
) ON [PRIMARY]
GO


