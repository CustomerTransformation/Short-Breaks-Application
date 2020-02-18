USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_listFilteredParentsCarers]    Script Date: 18/02/2020 10:44:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 29/01/2020
-- Description:	Generate filtered list of parents / carers
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_listFilteredParentsCarers] 
		@finYear as varchar(5)
		,@nameFilter as varchar(20)
		,@batchFilter as varchar(20) = ''
		,@batchName as varchar(20) = ''
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [ID_ParentCarer] as name
		  ,[reference]
		  ,[firstName] + ' ' + [lastName] + ' (' + [reference] + ')' as display
	  FROM [dbo].[shortBreaks_ParentCarer] carer
	 LEFT JOIN (SELECT ParentCarerRef
		,COUNT(ID_ChildYoungPer) as noChild
		,SUM(CASE WHEN eligibleChecked = 'yes' THEN 1 ELSE 0 END) as noElig
		,SUM(CASE WHEN eligibleChecked = 'no' THEN 1 ELSE 0 END) as noNotE
	  FROM [dbo].[shortBreaks_ChildYoungPerson]
	 WHERE finYear like '%' + @finYear + '%'
	 GROUP BY ParentCarerRef, finYear) child
	 ON carer.reference = child.ParentCarerRef
	 LEFT JOIN dbo.shortBreaks_AllocationCard cardA
	 ON carer.reference = cardA.ParentCarerRef
		AND carer.forYear = cardA.forYear
	  WHERE carer.forYear like '%' + @finYear + '%'
	  AND (@nameFilter = ''
			OR firstName like '%' + @nameFilter + '%'
			OR lastName like '%' + @nameFilter + '%')
	 AND (@batchFilter = ''
			OR (@batchFilter like '%noBatch%eligibilityComp%'
				AND ISNULL(cardA.batchUpload, '') = ''
				AND child.noChild = child.noElig + child.noNotE
				AND child.noElig > 0)
			OR (@batchFilter = 'noBatch'
				AND ISNULL(cardA.batchUpload, '') = '')
			OR (@batchFilter = 'eligibilityComp'
				AND child.noChild = child.noElig + child.noNotE
				AND child.noElig > 0))
	AND (@batchName = '' OR cardA.batchUpload = @batchName)
	order by display


END
GO


