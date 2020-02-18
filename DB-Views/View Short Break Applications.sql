USE [FStepChildrenAndFamilies_prod]
GO

/****** Object:  View [dbo].[View Short Break Applications]    Script Date: 18/02/2020 12:12:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View Short Break Applications]
AS
SELECT        dbo.shortBreaks_ParentCarer.ID_ParentCarer, dbo.shortBreaks_ParentCarer.reference, dbo.shortBreaks_ParentCarer.firstName AS [Parent First Name], dbo.shortBreaks_ParentCarer.lastName AS [Parent Last Name], 
                         dbo.shortBreaks_ParentCarer.dateOfBirth AS [Parent Dob], dbo.[View ChildYoungPerson with ChildNum].firstName AS [Child First Name], dbo.[View ChildYoungPerson with ChildNum].lastName AS [Child Last Name], 
                         dbo.[View ChildYoungPerson with ChildNum].DoB AS [Child DoB], dbo.ageFromDoB(dbo.[View ChildYoungPerson with ChildNum].DoB) AS [Child Age], GETDATE() AS [Todays Date], dbo.shortBreaks_ParentCarer.flat, 
                         dbo.shortBreaks_ParentCarer.house, dbo.shortBreaks_ParentCarer.road, dbo.shortBreaks_ParentCarer.town, dbo.shortBreaks_ParentCarer.postCode, dbo.shortBreaks_ParentCarer.mobile, 
                         dbo.shortBreaks_ParentCarer.phoneNum, dbo.shortBreaks_ParentCarer.email, dbo.[View ChildYoungPerson with ChildNum].attendEducation, dbo.[View ChildYoungPerson with ChildNum].EHCplan, 
                         dbo.[View ChildYoungPerson with ChildNum].nameOfSchool, dbo.shortBreaks_ParentCarer.dateSubmitted, dbo.[View ChildYoungPerson with ChildNum].eligibleChecked, 
                         dbo.[View ChildYoungPerson with ChildNum].addedMonitor, dbo.shortBreaks_ParentCarer.organisation, dbo.shortBreaks_ParentCarer.previously, dbo.shortBreaks_ParentCarer.stillHave, 
                         dbo.shortBreaks_AllocationCard.batchUpload, dbo.shortBreaks_AllocationCard.cardCreated, dbo.shortBreaks_AllocationCard.cardExpiry, dbo.shortBreaks_AllocationCard.cardholderID, 
                         dbo.shortBreaks_AllocationCard.numChildren, dbo.shortBreaks_AllocationCard.allocationStarts, dbo.shortBreaks_AllocationCard.allocationEnds, CASE WHEN [ChildNum] = 1 THEN totalDays ELSE NULL END AS totalDays, 
                         CASE WHEN [ChildNum] = 1 THEN amount ELSE NULL END AS amount, dbo.shortBreaks_AllocationCard.scheduleToCFL, dbo.shortBreaks_AllocationCard.cardSent, dbo.shortBreaks_AllocationCard.childMonSS, 
                         dbo.shortBreaks_AllocationCard.Comments, dbo.shortBreaks_AllocationCard.forYear AS forYr, dbo.shortBreaks_ParentCarer.forYear
FROM            dbo.shortBreaks_ParentCarer LEFT OUTER JOIN
                         dbo.[View ChildYoungPerson with ChildNum] ON dbo.shortBreaks_ParentCarer.reference = dbo.[View ChildYoungPerson with ChildNum].ParentCarerRef LEFT OUTER JOIN
                         dbo.shortBreaks_AllocationCard ON dbo.shortBreaks_ParentCarer.reference = dbo.shortBreaks_AllocationCard.parentCarerRef AND 
                         dbo.[View ChildYoungPerson with ChildNum].finYear LIKE '%' + dbo.shortBreaks_AllocationCard.forYear + '%' AND dbo.shortBreaks_ParentCarer.forYear LIKE '%' + dbo.shortBreaks_AllocationCard.forYear + '%'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[43] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "shortBreaks_ParentCarer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 459
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "shortBreaks_AllocationCard"
            Begin Extent = 
               Top = 33
               Left = 631
               Bottom = 329
               Right = 801
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "View ChildYoungPerson with ChildNum"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 232
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 44
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Widt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View Short Break Applications'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'h = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 6810
         Alias = 1680
         Table = 4980
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View Short Break Applications'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View Short Break Applications'
GO


