USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_listYears]    Script Date: 18/02/2020 10:45:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 29/01/2020
-- Description:	List short break financial years with current year first
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_listYears] 
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ROW_NUMBER() OVER (ORDER BY [current] DESC, startDate DESC) as name
		  ,[ID_FinYear]
		  ,[Name] as display
		  ,[standardAmount]
		  ,[startDate]
		  ,[endDate]
		  ,CASE WHEN [current] = 1 THEN 'yes' ELSE '' END as [current]
		  ,[createdBy]
		  ,[createdDate]
		  ,[modifiedBy]
		  ,[modifiedDate]
	  FROM [dbo].[shortBreaks_FinancialYear]


END
GO


