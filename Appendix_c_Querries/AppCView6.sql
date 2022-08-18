USE [GuestHouse2020]
GO


SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_booking_5046_details AS
SELECT [dbo].[guest].first_name + ' ' + [dbo].[guest].last_name AS 'Guest Name', 
[dbo].[booking].booking_date AS 'Checkin Date',  DATEADD(DAY,[dbo].[booking].nights, [dbo].[booking].booking_date) AS 'Checkout Date',
[dbo].[booking].occupants
FROM [dbo].[guest]
INNER JOIN [dbo].[booking] on [dbo].[booking].guest_id=[dbo].[guest].id
WHERE [dbo].[booking].booking_id=5046
GO

SELECT * FROM V_booking_5046_details
GO