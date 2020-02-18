USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[ShortBreaks_loadParentCarer]    Script Date: 18/02/2020 10:46:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 30/01/2020
-- Description:	load Parent / Carer details
-- =============================================
CREATE PROCEDURE [dbo].[ShortBreaks_loadParentCarer]
	@finYear as varchar(10)
	,@Reference as Varchar(15)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [ID_ParentCarer]
		  ,[reference] as referencePC
		  ,[title] as Title_out
		  ,[firstName] as First_Name_out
		  ,[lastName] as Surname_out
		  ,[dateOfBirth] as Date_Of_Birth_out
		  ,[email] as Email_Address_out
		  ,[phoneNum] as Phone_Number_out
		  ,[mobile] as Mobile_Number_out
		  ,[flat] as flat_out
		  ,[house] as house_out
		  ,[road] as street_out
		  ,[town] as town_out
		  ,[postCode] as postcode_out5
		  ,[uprn] as uprn_out
		  ,[eligable]
		  ,[dateSubmitted]
		  ,[previously]
		  ,[stillHave]
		  ,[organisation]
		  ,[createdBy]
		  ,[createdDate]
		  ,[modifiedBy]
		  ,[modifiedDate]
		  ,[title] as Title_out1
		  ,[firstName] as First_Name_out1
		  ,[lastName] as Surname_out1
		  ,[dateOfBirth] as Date_Of_Birth_out1
		  ,[email] as Email_Address_out1
		  ,[phoneNum] as Phone_Number_out1
		  ,[mobile] as Mobile_Number_out1
		  ,[dateSubmitted] as dateSubmitted1
		  ,[previously] as previously1
		  ,[stillHave] as stillHave1
		  ,[organisation] as organisation1
	  FROM [dbo].[shortBreaks_ParentCarer]
	 WHERE forYear like '%' + @finYear + '%'
	   AND reference = @Reference
END
GO


