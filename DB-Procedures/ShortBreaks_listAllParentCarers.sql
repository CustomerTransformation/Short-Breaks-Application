USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[ShortBreaks_listAllParentCarers]    Script Date: 18/02/2020 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 03/02/2020
-- Description:	list all Parent / Carer IDs as csv for select all
-- =============================================
CREATE PROCEDURE [dbo].[ShortBreaks_listAllParentCarers] 
		@finYear as varchar(10)
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT STRING_AGG( ISNULL([ID_ParentCarer], ' '), ',') as AllIDsList
	  FROM [dbo].[shortBreaks_ParentCarer]
	  WHERE forYear like '%' + @finYear + '%'


END
GO


