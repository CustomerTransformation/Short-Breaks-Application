USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_addUpdateChildYoung]    Script Date: 18/02/2020 10:43:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 27/01/2020
-- Description:	procedure to add the details of the children/young people entered
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_addUpdateChildYoung]
			@ParentCarerRef as varchar(15)
           ,@firstName as varchar(50)
           ,@lastName as varchar(50)
           ,@DoB as date
           ,@attendEducation as varchar(5)
           ,@EHCplan as varchar(5)
           ,@nameOfSchool as varchar(250)
           ,@eligible as varchar(10)
		   ,@IDchildYoung as varchar(10)
		   ,@user as varchar(50) = NULL
		   ,@eligibleChecked as varchar(5) = NULL
		   ,@addedMonitor varchar(5) = NULL
		   ,@currentYear as varchar(10) = NULL
		   ,@updateCarerRef as varchar(15) = NULL
		   ,@remove as varchar(5) = NULL
		   ,@updateR as varchar(5) = NULL
		   ,@maintain as varchar(5) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ID as int;

	SET @ID = NULLIF(@IDchildYoung, '');
	SET @currentYear = CASE WHEN ISNULL(@currentYear, '') = '' THEN dbo.ShortBreaksCurrFinYear() ELSE @currentYear END;
	
	IF ISNULL(@updateCarerRef, '') != ''
		SET @ParentCarerRef = @updateCarerRef;

	IF @maintain != 'yes'
		SET @updateR = 'yes';


	IF @ID is null AND @updateR = 'yes'
	BEGIN
		INSERT INTO [dbo].[shortBreaks_ChildYoungPerson]
				   ([ParentCarerRef]
				   ,[firstName]
				   ,[lastName]
				   ,[DoB]
				   ,[attendEducation]
				   ,[EHCplan]
				   ,[nameOfSchool]
				   ,[eligible]
				   ,createdDate
				   ,eligibleChecked
				   ,addedMonitor
				   ,finYear
				   ,[remove])
			 VALUES
				   (@ParentCarerRef
				   ,@firstName
				   ,@lastName
				   ,@DoB
				   ,@attendEducation
				   ,@EHCplan
				   ,@nameOfSchool
				   ,@eligible
				   ,GETDATE()
				   ,@eligibleChecked
				   ,@addedMonitor
				   ,@currentYear
				   ,@remove);
	END
	ELSE IF @updateR = 'yes'
	BEGIN
		UPDATE [dbo].[shortBreaks_ChildYoungPerson]
		   SET [ParentCarerRef] = @ParentCarerRef
			  ,[firstName] = @firstName
			  ,[lastName] = @lastName
			  ,[DoB] = @DoB
			  ,[attendEducation] = @attendEducation
			  ,[EHCplan] = @EHCplan
			  ,[nameOfSchool] = @nameOfSchool
			  ,[eligible] = CASE WHEN @eligible != '' THEN @eligible ELSE eligible END
			  ,modifiedBy = @user
			  ,modifiedDate = GETDATE()
			  ,eligibleChecked = @eligibleChecked
			  ,addedMonitor = @addedMonitor
			  ,finYear = @currentYear
			  ,[remove] = @remove
		 WHERE ID_ChildYoungPer = @ID;
	END
	ELSE
		SELECT 'no update' as result;

END
GO


