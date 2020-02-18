USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  UserDefinedFunction [dbo].[ageFromDoB]    Script Date: 18/02/2020 10:41:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 27/01/2020
-- Description:	Acurately calculate age from date of birth
-- =============================================
CREATE FUNCTION [dbo].[ageFromDoB] 
(
	@DoB as date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @AgeSimple as int
			,@Age as int

	SET @AgeSimple = DATEDIFF(YY,@Dob,GETDATE())

	SET @Age = @AgeSimple - CASE WHEN DATEADD(YY, @AgeSimple, @DoB) > GETDATE() THEN 1 ELSE 0 END

	-- Return the result of the function
	RETURN @Age

END
GO


