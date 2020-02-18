USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_loadAllocationInfo]    Script Date: 18/02/2020 10:45:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 03/02/2020
-- Description:	load Card Details onto maintain form
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_loadAllocationInfo]
	@finYear as varchar(10)
	,@Reference as Varchar(15)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ID as int
			,@finYrEnd as date
			,@finYrStart as date
			,@finYrDays as int
			,@finYrAmount as decimal(10,2)
			,@amountDay as decimal(10,2)
			,@noChildren as int
			,@noElig as int
			,@noNotElig as int
			,@calcAmount as decimal(10,2) = 0
			,@allocEnd as date
			,@totalDays as int = 0

	SELECT @ID = ID_Allocation
	FROM dbo.shortBreaks_AllocationCard
	WHERE parentCarerRef = @Reference
	  AND forYear like '%' + @finYear + '%'
	  AND (NULLIF(allocationStarts, '') IS NOT NULL
			OR NULLIF(allocationEnds, '') IS NOT NULL
			OR NULLIF(totalDays, 0) IS NOT NULL
			OR NULLIF(amount, 0) IS NOT NULL
			OR NULLIF(scheduleToCFL, '') IS NOT NULL)

	IF @ID IS NOT NULL
		SELECT allocationStarts
				,allocationEnds
				,totalDays as numberOfDaysCal
				,amount as amountOfPayment
				,scheduleToCFL as datePaymentSchedul
				,allocationStarts as allocationStarts1
				,allocationEnds as allocationEnds1
				,totalDays as numberOfDaysCal1
				,amount as amountOfPayment1
				,scheduleToCFL as datePaymentSchedul1
		FROM dbo.shortBreaks_AllocationCard
		WHERE ID_Allocation = @ID;
	ELSE
	BEGIN
		
		SELECT @noChildren = COUNT(ID_ChildYoungPer)
			  ,@noElig = SUM(CASE WHEN eligibleChecked = 'yes' THEN 1 ELSE 0 END) 
			  ,@noNotElig = SUM(CASE WHEN eligibleChecked = 'no' THEN 1 ELSE 0 END) 
		  FROM [dbo].[shortBreaks_ChildYoungPerson]
		 WHERE finYear like '%' + @finYear + '%'
		   AND ParentCarerRef = @Reference
		   AND remove != 'yes'
		
		IF @noChildren = @noElig + @noNotElig AND @noElig > 0
		BEGIN
			SELECT @finYrEnd = endDate
					,@finYrStart = startDate
					,@finYrDays = DATEDIFF(DD, startDate, endDate)
					,@finYrAmount = standardAmount
			FROM dbo.shortBreaks_FinancialYear
			WHERE @finYear = '#' + CAST(ID_FinYear as varchar(10)) + '#';

			SET @amountDay = @finYrAmount / @finYrDays;
			SET @allocEnd = @finYrStart;

			SELECT @totalDays = @totalDays + CASE WHEN dbo.ageFromDoBatDate(DoB,@finYrEnd) = 18 THEN DATEDIFF(DD, @finYrStart, DATEADD(YY, 18, DoB)) ELSE @finYrDays END
					,@allocEnd = CASE WHEN dbo.ageFromDoBatDate(DoB,@finYrEnd) = 18 THEN CASE WHEN DATEADD(YY, 18, DoB) > @allocEnd THEN  DATEADD(YY, 18, DoB) ELSE @allocEnd END ELSE @finYrEnd END
			FROM dbo.shortBreaks_ChildYoungPerson
			WHERE ParentCarerRef = @Reference
			AND finYear = @finYear
			AND eligibleChecked = 'yes'
			AND remove != 'yes';

			SELECT @finYrStart as allocationStarts
					,@allocEnd as allocationEnds
					,@totalDays as numberOfDaysCal
					,CASE WHEN @totalDays = @finYrDays THEN @finYrAmount ELSE @totalDays * @amountDay END as amountOfPayment
			
		END

	END

END
GO


