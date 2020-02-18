USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_addUpdateParentCarer]    Script Date: 18/02/2020 10:43:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 27/01/2020
-- Description:	adding or updating parent / carer details
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_addUpdateParentCarer] 
			@reference as varchar(15)
           ,@title as varchar(10)
           ,@firstName as varchar(50)
           ,@lastName as varchar(50)
           ,@dateOfBirth as date
           ,@email as varchar(255)
           ,@phoneNum as varchar(50)
           ,@mobile as varchar(50)
           ,@flat as varchar(50)
           ,@house as varchar(50)
           ,@road as varchar(50)
           ,@town as varchar(50)
           ,@postCode as varchar(10)
           ,@uprn as varchar(10)
		   ,@previously as varchar(5)
		   ,@stillHave as varchar(5)
           ,@eligable as varchar(20)
		   ,@IDparentCarer as varchar(10)
		   ,@applicationDate as varchar(20) = NULL
		   ,@user as varchar(50) = NULL
		   ,@currentYear as varchar(10) = NULL
		   ,@organisation as varchar(80) = NULL
		   ,@refMaintain as varchar(15) = NUll
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ID as int
			,@dateApplication as datetime
			,@creator as varchar(50);

	SET @ID = NULLIF(@IDparentCarer, '');
	SET @creator = NULLIF(@user, '');
	SET @currentYear = CASE WHEN ISNULL(@currentYear, '') = '' THEN dbo.ShortBreaksCurrFinYear() ELSE @currentYear END;

	IF ISNULL(@reference, '') = ''
		SET @reference = @refMaintain

	IF NULLIF(@applicationDate, '') is NULL
		SET @dateApplication = GETDATE()
	ELSE 
		SET @dateApplication = @applicationDate

	IF @ID is null
	BEGIN
		INSERT INTO [dbo].[shortBreaks_ParentCarer]
				   ([reference]
				   ,[title]
				   ,[firstName]
				   ,[lastName]
				   ,[dateOfBirth]
				   ,[email]
				   ,[phoneNum]
				   ,[mobile]
				   ,[flat]
				   ,[house]
				   ,[road]
				   ,[town]
				   ,[postCode]
				   ,[uprn]
				   ,[eligable]
				   ,[previously]
				   ,[stillHave]
				   ,[organisation]
				   ,dateSubmitted
				   ,createdBy
				   ,createdDate
				   ,forYear)
			 VALUES
				   (@reference
				   ,@title
				   ,@firstName
				   ,@lastName
				   ,@dateOfBirth
				   ,@email
				   ,@phoneNum
				   ,@mobile
				   ,@flat
				   ,@house
				   ,@road
				   ,@town
				   ,@postCode
				   ,@uprn
				   ,@eligable
				   ,@previously
				   ,@stillHave
				   ,@organisation
				   ,@dateApplication
				   ,@creator
				   ,GETDATE()
				   ,@currentYear)
	END
	ELSE
	BEGIN
		UPDATE [dbo].[shortBreaks_ParentCarer]
		   SET [reference] = @reference
			  ,[title] = @title
			  ,[firstName] = @firstName
			  ,[lastName] = @lastName
			  ,[dateOfBirth] = @dateOfBirth
			  ,[email] = @email
			  ,[phoneNum] = @phoneNum
			  ,[mobile] = @mobile
			  ,[flat] = @flat
			  ,[house] = @house
			  ,[road] = @road
			  ,[town] = @town
			  ,[postCode] = @postCode
			  ,[uprn] = @uprn
			  ,[previously] = @previously
			  ,[stillHave] = @stillHave
			  ,[organisation] = @organisation
			  ,[eligable] = CASE WHEN @creator = '' THEN '' ELSE @eligable END
			  ,modifiedBy = @creator
			  ,modifiedDate = GETDATE()
		 WHERE ID_ParentCarer = @ID
	END

END
GO


