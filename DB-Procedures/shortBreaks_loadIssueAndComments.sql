USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_loadIssueAndComments]    Script Date: 18/02/2020 10:45:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 04/02/2020
-- Description:	load Issue and Comments onto maintain form
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_loadIssueAndComments]
	@finYear as varchar(10)
	,@Reference as Varchar(15)
AS
BEGIN
	SET NOCOUNT ON;

	
		SELECT cardSent as dateCardSent
				,childMonSS as childMonitoringDat
				,Comments as comments
				,cardSent as dateCardSent1
				,childMonSS as childMonitoringDat1
				,Comments as comments1
		FROM dbo.shortBreaks_AllocationCard
	WHERE parentCarerRef = @Reference
	  AND forYear like '%' + @finYear + '%'
END
GO


