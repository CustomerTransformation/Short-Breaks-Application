USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  StoredProcedure [dbo].[ShortBreaks_htmlSummaryOfClaim]    Script Date: 18/02/2020 10:44:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniel Gregory
-- Create date: 31/01/2020
-- Description:	Create an html summary of the claim
-- =============================================
CREATE PROCEDURE [dbo].[ShortBreaks_htmlSummaryOfClaim] 
			@finYear as varchar(10)
			,@Reference as Varchar(15)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @carer as varchar(1000)
			,@children as varchar(4000)
			,@noEligible as int = 0
			,@noNotEligible as int = 0
			,@noChild as int = 0
			,@htmlSum as varchar(max)
			,@canProceed as varchar(5)
			,@allocationCard1 as varchar(2000)
			,@allocationCard2 as varchar(1000)
	    


	SELECT @carer = '<tr><td>Reference</td><td>' + ISNULL([reference], '') + '</td></tr>' +
		  '<tr><td>Name</td><td>' + ISNULL([title], '') + ' ' + ISNULL([firstName], '') + ' ' + ISNULL([lastName], '') + '</td></tr>' +
		  '<tr><td>Date of Birth</td><td>' + ISNULL(CONVERT(varchar, [dateOfBirth], 103), '') + '</td></tr>' +
		  CASE WHEN ISNULL([email], '') != '' THEN '<tr><td>Email</td><td>' + [email] + '</td></tr>' ELSE '' END +
		  CASE WHEN ISNULL([phoneNum], '') != '' THEN '<tr><td>Phone number</td><td>' + [phoneNum] + '</td></tr>' ELSE '' END +
		  CASE WHEN ISNULL([mobile], '') != '' THEN '<tr><td>Mobile</td><td>' + [mobile] + '</td></tr>' ELSE '' END +
		  '<tr><td>Address</td><td>' + CASE WHEN ISNULL([flat], '') != '' THEN [flat] + '<br />' ELSE '' END +
		  CASE WHEN ISNULL([house], '') != '' THEN [house] + '<br />' ELSE '' END +
		  CASE WHEN ISNULL([road], '') != '' THEN [road] + '<br />'  ELSE '' END +
		  CASE WHEN ISNULL([town], '') != '' THEN [town] + '<br />'  ELSE '' END +
		  ISNULL([postCode], '') + '</td></tr>' +
		  '<tr><td>Date submitted</td><td>' + ISNULL(CONVERT(varchar, [dateSubmitted], 103), '') + '</td></tr>' +
		  '<tr><td>Previously had card</td><td>' + ISNULL([previously], '') + '</td></tr>' +
		  '<tr><td>Still has the card</td><td>' + ISNULL([stillHave], '') + '</td></tr>'
	  FROM [dbo].[shortBreaks_ParentCarer]
	  WHERE forYear like '%' + @finYear + '%'
	  AND [reference] = @Reference

	SET @htmlSum = '<table class="PCCfieldsT">' + @carer + '</table>'

	SET  @children = ''

	SELECT @children = @children + '<tr><td>' + ISNULL([firstName], '') + ' ' + ISNULL([lastName], '') + '</td>' +
				'<td>' + ISNULL(CONVERT(varchar, [DoB], 103), '') + '</td>' +
				'<td>' + ISNULL(CAST(dbo.ageFromDoB(DoB) as varchar(3)), '') + '</td>' +
				'<td>' + ISNULL([attendEducation], '') + '</td>' +
				'<td>' + ISNULL([EHCplan], '') + '</td>' +
				'<td>' + ISNULL([nameOfSchool], '') + '</td>' +
				'<td>' + ISNULL([eligibleChecked], '') + '</td>' +
				'<td>' + ISNULL([addedMonitor], '') + '</td></tr>' 
	  FROM [dbo].[shortBreaks_ChildYoungPerson]
	 WHERE finYear like '%' + @finYear + '%'
	   AND ParentCarerRef = @Reference

	SELECT @noChild = @noChild + 1
			,@noEligible = @noEligible + CASE WHEN eligibleChecked = 'yes' THEN 1 ELSE 0 END
			,@noNotEligible = @noNotEligible + CASE WHEN eligibleChecked = 'no' THEN 1 ELSE 0 END
	  FROM [dbo].[shortBreaks_ChildYoungPerson]
	 WHERE finYear like '%' + @finYear + '%'
	   AND ParentCarerRef = @Reference

	IF @noEligible > 0 AND @noChild = @noEligible + @noNotEligible
		SET @canProceed = 'yes'
	ELSE
		SET @canProceed = 'no'

		SET @children = '<table style="undefined;table-layout: fixed; width: 717px">' +
						'<colgroup>' +
						'<col style="width: 170px">' +
						'<col style="width: 87px">' +
						'<col style="width: 57px">' +
						'<col style="width: 59px">' +
						'<col style="width: 41px">' +
						'<col style="width: 155px">' +
						'<col style="width: 61px">' +
						'<col style="width: 87px">' +
						'</colgroup>' +
						  '<tr>' +
							'<th>Name</th>' +
							'<th>DoB</th>' +
							'<th>Age</th>' +
							'<th>Attends</th>' +
							'<th>EHC</th>' +
							'<th>Name of School</th>' +
							'<th>Eligible</th>' +
							'<th>Add Monitor</th>' +
						  '</tr>' + @children + '</table>'
	
	SET @htmlSum = @htmlSum + @children

	SELECT @allocationCard1 = '<tr><td>' + ISNULL([batchUpload], '') + '</td>' +
		   '<td>' + ISNULL(CONVERT(varchar, [cardCreated], 103), '') + 
		   ' / ' + ISNULL(CONVERT(varchar, [cardExpiry], 103), '') + '</td>' +
		   '<td>' + ISNULL([cardholderID], '') + '</td>' +
		   '<td>' + CAST(ISNULL([numChildren], '') as varchar(3)) + '</td>' +
		   '<td>' + ISNULL(CONVERT(varchar, [allocationStarts], 103), '') + 
		   ' / ' + ISNULL(CONVERT(varchar, [allocationEnds], 103), '') + '</td>' +
		   '<td>' + ISNULL(CAST([totalDays] as Varchar(5)), '') + '</td>' +
		   '<td>' + ISNULL(CAST([amount] as varchar(11)), '') + '</td></tr>'
		   ,@allocationCard2 = '<tr><td>' + ISNULL(CONVERT(varchar, [scheduleToCFL], 103), '') + '</td>' +
		   '<td>' + ISNULL(CONVERT(varchar, [cardSent], 103), '') + '</td>' +
		   '<td>' + ISNULL(CONVERT(varchar, [childMonSS], 103), '') + '</td>' +
		   '<td>' + ISNULL([Comments], '') + '</td></tr>'
	  FROM [dbo].[shortBreaks_AllocationCard]
	 WHERE forYear like '%' + @finYear + '%'
	   AND ParentCarerRef = @Reference
	
	
	IF @allocationCard1 IS NOT NULL
	BEGIN
		SET  @allocationCard1 = '<table class="tg" style="undefined;table-layout: fixed; width: 901px">' +
										'<colgroup>' +
										'<col style="width: 170px">' +
										'<col style="width: 174px">' +
										'<col style="width: 128px">' +
										'<col style="width: 88px">' +
										'<col style="width: 168px">' +
										'<col style="width: 86px">' +
										'<col style="width: 87px">' +
										'</colgroup>' +
										  '<tr>' +
											'<th class="tg-0lax">Batch</th>' +
											'<th class="tg-0lax">Card Created / Expiry</th>' +
											'<th class="tg-0lax">Cardholder ID</th>' +
											'<th class="tg-0lax">No Children</th>' +
											'<th class="tg-0lax">Allocation Start / End</th>' +
											'<th class="tg-0lax">Total Days</th>' +
											'<th class="tg-0lax">Amount</th>' +
										  '</tr>' + @allocationCard1 + '</table>' +
									'<table class="tg" style="undefined;table-layout: fixed; width: 828px">' +
										'<colgroup>' +
										'<col style="width: 122px">' +
										'<col style="width: 95px">' +
										'<col style="width: 128px">' +
										'<col style="width: 483px">' +
										'</colgroup>' +
											'<tr>' +
											'<th class="tg-0lax">schedule to CFL</th>' +
											'<th class="tg-0lax">Card Sent</th>' +
											'<th class="tg-0lax">Added to Child Monitoring</th>' +
											'<th class="tg-0lax">Comments</th>' +
											'</tr>' + @allocationCard2 + '</table>'

		SET @htmlSum = @htmlSum + @allocationCard1
	END

	  SELECT @htmlSum as htmlSummaryApp, @canProceed as canProceed


END
GO


