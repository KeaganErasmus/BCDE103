USE [GuestHouse2020]
GO

--Total revenue by each room type for November 2016.
SELECT DISTINCT [dbo].[room_type].description, 
		SUM([dbo].[rate].amount + [dbo].[booking].nights + e.Total) AS 'Total revenue'
FROM [dbo].[room_type]
		INNER JOIN [dbo].[rate] ON [dbo].[room_type].id=[dbo].[rate].room_type
		INNER JOIN [dbo].[booking] ON [dbo].[room_type].id=[dbo].[booking].room_type_requested
		INNER JOIN (SELECT booking_id, SUM([amount]) AS 'Total' FROM [dbo].[extra]
					GROUP BY booking_id) AS e ON [dbo].[booking].booking_id=e.booking_id
WHERE [dbo].[booking].booking_date like '2016-11-%'
GROUP BY  [dbo].[room_type].description
GO

--The top 10 highest paying customers for November 2016.
CREATE OR ALTER VIEW V_higestPaying
AS
SELECT	DISTINCT CONCAT([dbo].[guest].first_name, ' ', [dbo].[guest].last_name) AS 'Guest Name',
		SUM([dbo].[rate].amount + [dbo].[booking].nights + [dbo].[extra].amount) AS 'Total Payed'
FROM [dbo].[guest]
		INNER JOIN [dbo].[booking] ON [dbo].[booking].guest_id=[dbo].[guest].id
		INNER JOIN [dbo].[rate] ON [dbo].[rate].room_type=[dbo].[booking].room_type_requested
		INNER JOIN [dbo].[extra] ON [dbo].[booking].booking_id=[dbo].[extra].booking_id
GROUP BY	[dbo].[guest].first_name, [dbo].[guest].last_name
GO

SELECT  TOP 10 V_higestPaying.[Guest Name], V_higestPaying.[Total Payed]
FROM V_higestPaying
ORDER BY V_higestPaying.[Total Payed] DESC
GO

--The highest and lowest revenue earning “extra” purchased for the month of 
--November 2016.
SELECT 
	CASE 
		WHEN [dbo].[extra].description like '%Breakfast %' THEN 'Breakfast'
		WHEN [dbo].[extra].description like '%Phone Calls %' THEN 'Phone Calls'
		ELSE NULL
	END AS 'Extra',
	SUM(ISNULL([dbo].[extra].amount, 0)) AS 'Amount'
FROM [dbo].[extra]
	INNER JOIN [dbo].[booking] ON [dbo].[booking].booking_id=[dbo].[extra].booking_id
WHERE [dbo].[booking].booking_date like '2016-11-%'
GROUP BY CASE 
			WHEN [dbo].[extra].description like '%Breakfast %' THEN 'Breakfast'
			WHEN [dbo].[extra].description like '%Phone Calls %' THEN 'Phone Calls'
			ELSE NULL
		END

--Room occupation by type and number of guests for the days 1st to 10th of 
--November inclusive
SELECT	[dbo].[booking].room_type_requested,
		[dbo].[booking].occupants,
		[dbo].[booking].booking_date
FROM [dbo].[booking]
WHERE [dbo].[booking].booking_date between  '2016-11-1' and '2016-11-10'
ORDER BY [dbo].[booking].booking_date


--Quantity of “xtra_id” sold each day of November 2016.
SELECT DISTINCT	COUNT([dbo].[extra].extra_id) AS 'Quantity',
		[dbo].[booking].booking_date
FROM [dbo].[extra]
		INNER JOIN [dbo].[booking] ON [dbo].[booking].booking_id=[dbo].[extra].booking_id
WHERE [dbo].[booking].booking_date like '2016-11-%'
GROUP BY [dbo].[booking].booking_date