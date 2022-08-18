USE [GuestHouse2020]
GO


SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_total_payable_Andrew AS
SELECT [dbo].[guest].first_name, [dbo].[guest].last_name, SUM([dbo].[rate].amount * [dbo].[booking].nights) AS TotalAmount
FROM [dbo].[booking]
INNER JOIN [dbo].[guest] ON [dbo].[guest].[id] = [dbo].[booking].[guest_id]
INNER JOIN [dbo].[rate] ON [dbo].[booking].occupants=[dbo].[rate].occupancy AND
[dbo].[booking].room_type_requested=[dbo].[rate].room_type
WHERE [dbo].[guest].first_name + ' ' + [dbo].[guest].last_name = 'Dr Andrew Murrison'
GROUP BY [dbo].[guest].first_name, [dbo].[guest].last_name
GO

SELECT * FROM V_total_payable_Andrew
GO