USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_listOrganisations]    Script Date: 18/02/2020 10:44:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 04/02/2020
-- Description:	List organisations already entered
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_listOrganisations]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT DISTINCT organisation as name
					,organisation as display
		FROM dbo.shortBreaks_ParentCarer
		WHERE ISNULL(organisation, '') != ''
END
GO


