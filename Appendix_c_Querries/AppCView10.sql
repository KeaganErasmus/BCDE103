USE [GuestHouse2020]
GO


SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

CREATE OR ALTER VIEW V_total_nights_booked AS
SELECT [dbo].[guest].last_Name, [dbo].[guest].first_name, SUM(ISNULL([dbo].[booking].nights, 0)) AS 'Total Nights Booked', [dbo].[guest].address
FROM [dbo].[guest]
LEFT JOIN [dbo].[booking]
ON [dbo].[booking].guest_id=[dbo].[guest].id
GROUP BY [dbo].[guest].last_Name, [dbo].[guest].first_name,[dbo].[guest].address
GO

SELECT * FROM V_total_nights_booked
WHERE V_total_nights_booked.address like '%East%'
ORDER BY V_total_nights_booked.last_Name, V_total_nights_booked.first_name
GO