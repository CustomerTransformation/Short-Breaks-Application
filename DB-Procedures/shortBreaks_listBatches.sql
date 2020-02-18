USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_listBatches]    Script Date: 18/02/2020 10:44:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 03/02/2020
-- Description:	list all batches for Finacial year
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_listBatches]
		@finYear as varchar(10)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT DISTINCT batchUpload as name
			,batchUpload as display
	FROM dbo.shortBreaks_AllocationCard
	WHERE forYear like '%' + @finYear + '%'
END
GO


