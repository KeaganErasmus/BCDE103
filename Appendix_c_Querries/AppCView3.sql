USE [GuestHouse2020]
GO


SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_booking_info_5204 AS
SELECT [dbo].[booking].booking_id, [dbo].[booking].booking_date AS 'Checkin Date',  DATEADD(DAY,[dbo].[booking].nights, [dbo].[booking].booking_date) AS 'Checkout Date'
FROM [dbo].[booking]
WHERE [dbo].[booking].booking_id = 5204
GO

SELECT * FROM V_booking_info_5204
GO