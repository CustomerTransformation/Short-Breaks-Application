USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  Table [dbo].[shortBreaks_AllocationCard]    Script Date: 18/02/2020 10:35:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[shortBreaks_AllocationCard](
	[ID_Allocation] [int] IDENTITY(1,1) NOT NULL,
	[parentCarerRef] [varchar](15) NOT NULL,
	[batchUpload] [varchar](20) NULL,
	[cardCreated] [date] NULL,
	[cardExpiry] [date] NULL,
	[cardholderID] [varchar](50) NULL,
	[numChildren] [int] NULL,
	[allocationStarts] [date] NULL,
	[allocationEnds] [date] NULL,
	[totalDays] [int] NULL,
	[amount] [decimal](10, 2) NULL,
	[scheduleToCFL] [date] NULL,
	[cardSent] [date] NULL,
	[childMonSS] [date] NULL,
	[Comments] [varchar](1000) NULL,
	[forYear] [varchar](50) NULL,
	[createdDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[modifiedDate] [date] NULL,
	[modifiedBy] [varchar](50) NULL
) ON [PRIMARY]
GO


