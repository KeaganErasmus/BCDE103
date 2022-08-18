USE [GuestHouse2020]
GO


SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_5128_bill
AS
SELECT [dbo].[extra].booking_id, SUM([dbo].[extra].amount ) AS TotalBill
FROM [dbo].[extra]
WHERE [dbo].[extra].booking_id = 5128
GROUP BY [dbo].[extra].booking_id 
GO

SELECT * FROM V_5128_bill
GO

SELECT [dbo].[booking].booking_id, SUM([dbo].[rate].amount * [dbo].[booking].nights + V_5128_bill.TotalBill) AS TotalAmount
FROM [dbo].[booking]
INNER JOIN V_5128_bill ON [dbo].[booking].booking_id = V_5128_bill.booking_id
INNER JOIN [dbo].[rate] ON [dbo].[booking].occupants=[dbo].[rate].occupancy AND
[dbo].[booking].room_type_requested=[dbo].[rate].room_type
WHERE [dbo].[booking].booking_id = 5128
GROUP BY [dbo].[booking].booking_id
GO