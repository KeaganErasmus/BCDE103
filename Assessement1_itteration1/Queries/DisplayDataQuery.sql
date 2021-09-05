USE [AraWaitlist]
Go

SELECT * FROM [dbo].[Patient]
GO

--SELECT
--DATEDIFF(YEAR, [dbo].[Patient].DOB, Referral.referralDate) AS 'Age at Referral'

SELECT * FROM [dbo].[Surgeon]
GO

SELECT * FROM [dbo].[Refferer]
GO

SELECT * FROM [dbo].[Refferal]
GO

SELECT * FROM [dbo].[Refferal] INNER JOIN [dbo].[Surgeon] ON department = 'cardiothoracic'
GO

