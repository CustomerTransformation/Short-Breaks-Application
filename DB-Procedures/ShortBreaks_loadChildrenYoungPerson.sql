USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[ShortBreaks_loadChildrenYoungPerson]    Script Date: 18/02/2020 10:45:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 30/01/2020
-- Description:	load details of children your person for case reference
-- =============================================
CREATE PROCEDURE [dbo].[ShortBreaks_loadChildrenYoungPerson]
	@finYear as varchar(10)
	,@Reference as Varchar(15)
AS
BEGIN
	SET NOCOUNT ON

SELECT [ID_ChildYoungPer] as IDchild
      ,[ParentCarerRef]
      ,[firstName] as firstNameCF
      ,[lastName] as lastNameCF
      ,[DoB] as dateOfBirthCF
      ,[attendEducation] as attendSchoolEtc
      ,[EHCplan]
      ,[nameOfSchool]
      ,[eligible]
	  ,[eligibleChecked] as checkEligible
	  ,[addedMonitor] as childMonitoringAdd
  FROM [dbo].[shortBreaks_ChildYoungPerson]
  WHERE finYear like '%' + @finYear + '%'
    AND ParentCarerRef = @Reference
	AND [remove] != 'yes'
  Order by firstName, lastName


END
GO


