USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  UserDefinedFunction [dbo].[CSVtoListWithRowNum]    Script Date: 18/02/2020 10:39:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 05/02/2020
-- Description:	generate list with row numbers from csv
-- =============================================
CREATE FUNCTION [dbo].[CSVtoListWithRowNum]
(	
	@valuesCSV as varchar(max)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) rownum
			,value as item
	FROM STRING_SPLIT(@valuesCSV,',')
)
GO


