USE [GuestHouse2020]
GO


SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_total_payable AS
SELECT [dbo].[guest].first_name, [dbo].[guest].last_name, SUM(ISNULL([dbo].[rate].amount * [dbo].[booking].nights, 0)) AS TotalAmount
FROM [dbo].[booking]
FULL JOIN [dbo].[guest] ON [dbo].[guest].[id] = [dbo].[booking].[guest_id]
LEFT JOIN [dbo].[rate] ON [dbo].[booking].occupants=[dbo].[rate].occupancy
GROUP BY [dbo].[guest].first_name, [dbo].[guest].last_name
GO

SELECT * FROM V_total_payable
WHERE V_total_payable.first_name like '%Sir% P%' and V_total_payable.last_name like '%rd'
GO

SELECT * FROM booking