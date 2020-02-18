USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  UserDefinedFunction [dbo].[ShortBreaksCurrFinYear]    Script Date: 18/02/2020 10:41:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 30/01/2020
-- Description:	Returns the current financial year string
-- =============================================
CREATE FUNCTION [dbo].[ShortBreaksCurrFinYear] 
()
RETURNS varchar(10)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar as varchar(10)

	-- Add the T-SQL statements to compute the return value here
	SELECT TOP 1 @ResultVar = '#' + cast(ID_FinYear as varchar(5)) + '#'
	FROM dbo.shortBreaks_FinancialYear
	WHERE [current] = 1

	-- Return the result of the function
	RETURN @ResultVar

END
GO


