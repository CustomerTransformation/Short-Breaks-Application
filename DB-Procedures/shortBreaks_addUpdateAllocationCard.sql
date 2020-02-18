USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_addUpdateAllocationCard]    Script Date: 18/02/2020 10:43:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 30/01/2020
-- Description:	Add Update Allocation and Card details
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_addUpdateAllocationCard]
			@parentCarerRef as varchar(15)
           ,@batchUpload as varchar(20)
           ,@cardCreated as date
           ,@cardExpiry as date
           ,@cardholderID as varchar(50)
           ,@numChildren as int
           ,@allocationStarts as date
           ,@allocationEnds as date
           ,@totalDays as int
           ,@amount as varchar(11)
           ,@scheduleToCFL as date
           ,@cardSent as date
           ,@childMonSS as date
           ,@Comments as varchar(1000)
           ,@forYear as varchar(50)
           ,@user as varchar(50)
		   ,@upCard as varchar(5)
		   ,@upAllocation as varchar(5)
		   ,@upIssue as varchar(5) 
		   ,@reference as varchar(15)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ID as int
			,@amountDec as decimal(10,2);

	SET @amountDec = NULLIF(@amount, '');

	IF ISNULL(@parentCarerRef, '') = ''
		SET @parentCarerRef = @reference

	SELECT TOP 1 @ID = ID_Allocation
	  FROM [dbo].[shortBreaks_AllocationCard]
	 WHERE [parentCarerRef] = @parentCarerRef
	   AND [forYear] = @forYear


	   IF @ID IS NULL
	   BEGIN
		INSERT INTO [dbo].[shortBreaks_AllocationCard]
				   ([parentCarerRef]
				   ,[batchUpload]
				   ,[cardCreated]
				   ,[cardExpiry]
				   ,[cardholderID]
				   ,[numChildren]
				   ,[allocationStarts]
				   ,[allocationEnds]
				   ,[totalDays]
				   ,[amount]
				   ,[scheduleToCFL]
				   ,[cardSent]
				   ,[childMonSS]
				   ,[Comments]
				   ,[forYear]
				   ,[createdDate]
				   ,[createdBy])
			 VALUES
				   (@parentCarerRef
				   ,@batchUpload
				   ,@cardCreated
				   ,@cardExpiry
				   ,@cardholderID
				   ,@numChildren
				   ,@allocationStarts
				   ,@allocationEnds
				   ,@totalDays
				   ,@amountDec
				   ,@scheduleToCFL
				   ,NULLIF(@cardSent, '')
				   ,@childMonSS
				   ,@Comments
				   ,@forYear
				   ,GETDATE()
				   ,@user)
	END
	ELSE
	BEGIN
		UPDATE [dbo].[shortBreaks_AllocationCard]
		   SET [batchUpload] = CASE WHEN @upCard = 'yes' THEN @batchUpload ELSE [batchUpload] END
			  ,[cardCreated] = CASE WHEN @upCard = 'yes' THEN @cardCreated ELSE [cardCreated] END
			  ,[cardExpiry] = CASE WHEN @upCard = 'yes' THEN @cardExpiry ELSE [cardExpiry] END
			  ,[cardholderID] = CASE WHEN @upCard = 'yes' THEN @cardholderID ELSE [cardholderID] END
			  ,[numChildren] = CASE WHEN @upCard = 'yes' THEN @numChildren ELSE [numChildren] END
			  ,[allocationStarts] = CASE WHEN @upAllocation = 'yes' THEN @allocationStarts ELSE [allocationStarts] END
			  ,[allocationEnds] = CASE WHEN @upAllocation = 'yes' THEN @allocationEnds ELSE [allocationEnds] END
			  ,[totalDays] = CASE WHEN @upAllocation = 'yes' THEN @totalDays ELSE [totalDays] END
			  ,[amount] = CASE WHEN @upAllocation = 'yes' THEN @amountDec ELSE [amount] END
			  ,[scheduleToCFL] = CASE WHEN @upAllocation = 'yes' THEN NULLIF(@scheduleToCFL, '') ELSE [scheduleToCFL] END
			  ,[cardSent] = CASE WHEN @upIssue = 'yes' THEN NULLIF(@cardSent, '') ELSE [cardSent] END
			  ,[childMonSS] = CASE WHEN @upIssue = 'yes' THEN NULLIF(@childMonSS, '') ELSE [childMonSS] END
			  ,[Comments] = CASE WHEN @upIssue = 'yes' THEN @Comments ELSE [Comments] END
			  ,[modifiedDate] = GETDATE()
			  ,[modifiedBy] = @user
		 WHERE ID_Allocation = @ID
	END



END
GO


