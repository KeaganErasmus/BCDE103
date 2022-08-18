USE [GuestHouse2020]
GO

SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_list_of_rooms AS 
SELECT [dbo].[room].room_type
FROM [dbo].[room]
GO

SELECT * FROM V_list_of_rooms
GO