USE [GuestHouse2020]
GO


SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_list_of_people_bookings_26Nov AS
SELECT [dbo].[guest].first_name + ' ' + [dbo].[guest].last_name AS 'Guest Name', [dbo].[booking].room_no, [dbo].[booking].booking_date
FROM [dbo].[guest]
INNER JOIN [dbo].[booking] on [dbo].[booking].guest_id=[dbo].[guest].id
WHERE [dbo].[booking].booking_date = '2016-11-26' and [dbo].[booking].room_no = 209
GO

SELECT * FROM V_list_of_people_bookings_26Nov
GO