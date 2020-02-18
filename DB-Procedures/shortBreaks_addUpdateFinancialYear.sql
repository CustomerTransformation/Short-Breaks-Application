USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[shortBreaks_addUpdateFinancialYear]    Script Date: 18/02/2020 10:43:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 29/01/2020
-- Description:	Add or update short break financial year
-- =============================================
CREATE PROCEDURE [dbo].[shortBreaks_addUpdateFinancialYear]
				@Name as varchar(25)
			   ,@standardAmount as decimal(10,2)
			   ,@startDate as date
			   ,@endDate as date
			   ,@current as varchar(5)
			   ,@user as varchar(50)
			   ,@IDyear as varchar(10)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ID as int
			,@currbit as bit

	SET @currbit = CASE WHEN @current = 'yes' THEN 1 ELSE 0 END

	SET @ID = NULLIF(@IDyear, '')

	IF @ID is not null
	BEGIN
		UPDATE [dbo].[shortBreaks_FinancialYear]
		   SET [Name] = @Name
			  ,[standardAmount] = @standardAmount
			  ,[startDate] = @startDate
			  ,[endDate] = @endDate
			  ,[current] = @currbit
			  ,[modifiedBy] = @user
			  ,[modifiedDate] = GETDATE()
		 WHERE ID_FinYear = @ID;
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[shortBreaks_FinancialYear]
				   ([Name]
				   ,[standardAmount]
				   ,[startDate]
				   ,[endDate]
				   ,[current]
				   ,[createdBy]
				   ,[createdDate])
			 VALUES
				   (@Name
				   ,@standardAmount
				   ,@startDate
				   ,@endDate
				   ,@currbit
				   ,@user
				   ,GETDATE());
		SET @ID = SCOPE_IDENTITY()
	END

	IF @current = 'yes'
		UPDATE [dbo].[shortBreaks_FinancialYear]
			SET [current] = 0
		WHERE ID_FinYear != @ID
END
GO


