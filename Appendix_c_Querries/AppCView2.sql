USE [GuestHouse2020]
GO


SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_lists_of_guests AS 
SELECT [dbo].[guest].first_name + ' ' + [dbo].[guest].last_name AS 'Guest Name', [dbo].[guest].address
FROM [dbo].[guest]
GO

SELECT * FROM V_lists_of_guests
GO