USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_loadCardDetails]    Script Date: 18/02/2020 10:45:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 03/02/2020
-- Description:	load Card Details onto maintain form
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_loadCardDetails]
	@finYear as varchar(10)
	,@Reference as Varchar(15)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT batchUpload
			,cardCreated
			,cardExpiry as cardExpiryDate
			,cardholderID
			,numChildren as numberOfChidrenW
			,batchUpload as batchUpload1
			,cardCreated as cardCreated1
			,cardExpiry as cardExpiryDate1
			,cardholderID as cardholderID1
			,numChildren as numberOfChidrenW1
	FROM dbo.shortBreaks_AllocationCard
	WHERE parentCarerRef = @Reference
	  AND forYear like '%' + @finYear + '%'

END
GO


