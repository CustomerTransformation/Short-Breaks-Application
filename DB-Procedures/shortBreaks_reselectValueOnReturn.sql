USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_reselectValueOnReturn]    Script Date: 18/02/2020 10:46:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 05/02/2020
-- Description:	re select the returning value
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_reselectValueOnReturn]
		@listCounts as varchar(500)
		,@listIDs as varchar(2000)
AS
BEGIN
	SET NOCOUNT ON;

	IF len(@listCounts) > 6
	BEGIN
		SELECT cnt.item as accNum
				,ids.item as recordAccessed
		INTO #TEMP
		FROM dbo.CSVtoListWithRowNum(@listCounts) cnt
		INNER JOIN dbo.CSVtoListWithRowNum(@listIDs) ids
		ON cnt.rownum = ids.rownum

		SELECT TOP (1) *
		FROM #TEMP
		ORDER BY accNum desc

		DROP TABLE #TEMP
	END
	ELSE
		SELECT @listCounts as passedCounts
		  ,LEN(@listCounts) as lengthCounts
		  ,'no selection' as msg
END
GO


