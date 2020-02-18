USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_addUpdateMultCardBatch]    Script Date: 18/02/2020 10:43:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 03/02/2020
-- Description:	Create or Update card batch on multiple applications
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_addUpdateMultCardBatch] 
		@finYear as varchar(10)
		,@carerReferences as varchar(max)
		,@batchName as varchar(20)
		,@batchCreated as varchar(15)
		,@batchExpiry as varchar(15)
		,@user as varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @createDate as date
			,@expireDate as date

	SET @createDate = NULLIF(@batchCreated, '')
	SET @expireDate = NULLIF(@batchExpiry, '')

    SELECT reference
	INTO #Temp
	FROM dbo.shortBreaks_ParentCarer car
	INNER JOIN string_split(@carerReferences, ',') sel
	ON car.ID_ParentCarer = sel.value
	WHERE car.forYear like '%' + @finYear + '%'

	IF @batchName != ''
	BEGIN
		UPDATE allCrd
			SET batchUpload = @batchName
				,modifiedDate = GETDATE()
				,modifiedBy = @user
		FROM dbo.shortBreaks_AllocationCard allCrd
		INNER JOIN #Temp tmp
		ON tmp.reference = allCrd.parentCarerRef

		INSERT INTO dbo.shortBreaks_AllocationCard
			(parentCarerRef
			 ,forYear
			 ,batchUpload
			 ,createdDate
			 ,createdBy)
		SELECT reference
				,@finYear
				,@batchName
				,GETDATE()
				,@user
		FROM #Temp tmp
		LEFT JOIN dbo.shortBreaks_AllocationCard allCrd
		on tmp.reference = allCrd.parentCarerRef AND allCrd.forYear = @finYear
		WHERE allCrd.parentCarerRef is NULL
	END

	IF @createDate IS NOT NULL
	BEGIN
		UPDATE allCrd
			SET cardCreated = @createDate
				,cardExpiry = @expireDate
				,modifiedDate = GETDATE()
				,modifiedBy = @user
		FROM dbo.shortBreaks_AllocationCard allCrd
		INNER JOIN #Temp tmp
		ON tmp.reference = allCrd.parentCarerRef

		INSERT INTO dbo.shortBreaks_AllocationCard
			(parentCarerRef
			 ,forYear
			 ,cardCreated
			 ,cardExpiry
			 ,createdDate
			 ,createdBy)
		SELECT reference
				,@finYear
				,@createDate
				,@expireDate
				,GETDATE()
				,@user
		FROM #Temp tmp
		LEFT JOIN dbo.shortBreaks_AllocationCard allCrd
		on tmp.reference = allCrd.parentCarerRef AND allCrd.forYear = @finYear
		WHERE allCrd.parentCarerRef is NULL

	END

	DROP TABLE #Temp


END
GO


