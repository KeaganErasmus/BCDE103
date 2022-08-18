USE [GuestHouse2020]
GO

---Q1. List the people who has booked room number 101 on 17th November 2016.
SELECT * FROM [dbo].[booking] 
WHERE [room_no] = 101 AND [booking_date] = '2016-11-17'

---Q2. Give the booking date and the number of nights for guest 1540.
SELECT [booking_date], [nights] FROM [dbo].[booking] 
WHERE [guest_id] = 1540

---Q3. List the arrival time and the first and last names for all guests due to arrive on 2016-11-05, order the output by time of arrival.
SELECT [first_name], [last_name], [arrival_time] 
FROM [dbo].[guest], [dbo].[booking] 
WHERE [booking_date] = '2016-11-05' 
ORDER BY [arrival_time]

---Q4. Give the daily rate that should be paid for bookings with ids 5152, 5165, 5154 and 5295. Include booking id, room type, number of occupants and the amount.
SELECT [booking_id],[room_type],[occupants],[amount] 
FROM [dbo].[booking]
INNER JOIN [dbo].[rate] ON [dbo].[booking].occupants=[dbo].[rate].occupancy AND
[dbo].[booking].room_type_requested=[dbo].[rate].room_type
WHERE [dbo].[booking].booking_id IN (5152, 5165,  5154, 5295)


---Q5. Find who is staying in room 101 on 2016-12-03, include first name, last name and address.
SELECT [dbo].[guest].first_name, [dbo].[guest].last_name, [dbo].[guest].address, [dbo].[booking].room_no, [dbo].[booking].booking_date
FROM [dbo].[guest]
INNER JOIN [dbo].[booking] ON [dbo].[guest].id = [dbo].[booking].guest_id 
WHERE [dbo].[booking].room_no = 101 AND [dbo].[booking].booking_date = '2016-12-03'

---Q6. For guests 1185 and 1270 show the number of bookings made and the total number of nights. Your output should include the guest id and the total number of bookings and the total number of nights.
SELECT [dbo].[guest].id, SUM([dbo].[booking].nights) AS NumberOfNights, COUNT([dbo].[booking].[booking_id]) AS NumberOfBookings
FROM [dbo].[guest]
INNER JOIN [dbo].[booking] ON [dbo].[guest].id = [dbo].[booking].guest_id
WHERE [dbo].[guest].id = 1185 or [dbo].[booking].guest_id = 1270 
GROUP BY [dbo].[guest].id

---Q7. Show the total amount payable by guest Ruth Cadbury for her room bookings. You should JOIN to the rate table using room_type_requested and occupants.
SELECT [dbo].[guest].first_name, [dbo].[guest].last_name, SUM([dbo].[rate].amount * [dbo].[booking].nights) AS TotalAmount
FROM [dbo].[booking]
INNER JOIN [dbo].[guest] ON [dbo].[guest].[id] = [dbo].[booking].[guest_id]
INNER JOIN [dbo].[rate] ON [dbo].[booking].occupants=[dbo].[rate].occupancy AND
[dbo].[booking].room_type_requested=[dbo].[rate].room_type
WHERE [dbo].[guest].first_name + ' ' + [dbo].[guest].last_name = 'Ruth Cadbury'
GROUP BY [dbo].[guest].first_name, [dbo].[guest].last_name


---Q8. Calculate the total bill for booking 5346 including extras.
--Write this in better syntax
CREATE OR ALTER VIEW view_extra 
AS
SELECT [dbo].[extra].booking_id, SUM([dbo].[extra].amount ) AS TotalBill
FROM [dbo].[extra]
WHERE [dbo].[extra].booking_id = 5346
GROUP BY [dbo].[extra].booking_id 
GO
SELECT * FROM view_extra
GO

SELECT [dbo].[booking].booking_id, SUM([dbo].[rate].amount * [dbo].[booking].nights + view_extra.TotalBill) AS TotalAmount
FROM [dbo].[booking]
INNER JOIN view_extra ON [dbo].[booking].booking_id = view_extra.booking_id
INNER JOIN [dbo].[rate] ON [dbo].[booking].occupants=[dbo].[rate].occupancy AND
[dbo].[booking].room_type_requested=[dbo].[rate].room_type
WHERE [dbo].[booking].booking_id = 5346
GROUP BY [dbo].[booking].booking_id


---Q9. For every guest who has the word “Edinburgh” in their address show the total number of nights booked. Be sure to include 0 for those guests who have never had a booking. 
--Show last name, first name, address and number of nights. Order by last name then first name.
SELECT [dbo].[guest].last_Name, [dbo].[guest].first_name, [dbo].[guest].address, 
	CASE 
		WHEN([dbo].[booking].guest_id=[dbo].[guest].id) THEN SUM([dbo].[booking].nights)
		ELSE 0
	END AS TotalNights
FROM [dbo].[booking]
RIGHT JOIN [dbo].[guest] ON [dbo].[booking].guest_id = [dbo].[guest].id
WHERE [dbo].[guest].address like '%Edinburgh%'
GROUP BY [dbo].[guest].last_name, [dbo].[guest].first_name, [dbo].[guest].address, [dbo].[booking].guest_id, [dbo].[guest].id
ORDER BY [dbo].[guest].last_name, [dbo].[guest].first_name

---Q10. For each day of the week beginning 2016-11-25 show the number of bookings starting that day. Be sure to show all the days of the week in the correct order.
SELECT  [dbo].[booking].booking_date, DATENAME(WEEKDAY, [dbo].[booking].booking_date) AS 'DAY', COUNT([dbo].[booking].booking_date) AS 'Number of bookings'
FROM [dbo].[booking]
WHERE [dbo].[booking].booking_date BETWEEN '2016-11-25' AND '2016-12-01'
GROUP BY [dbo].[booking].booking_date
ORDER BY DATEPART(dw, [booking].booking_date)
--GET RID OF ORDER BY IF YOU WANT DATE ORDER :)


---Q11. Show the number of guests in the hotel on the night of 2016-11-21. Include all occupants who checked in that day but not those who checked out.
SELECT  SUM([dbo].[booking].occupants) AS Guests FROM [dbo].[booking] 
WHERE [dbo].[booking].booking_date <= '2016-11-21' AND DATEADD(DAY, [dbo].[booking].nights, [dbo].[booking].booking_date) > '2016-11-21'

---Q12. List the rooms that are free on the day 25th Nov 2016.
SELECT [dbo].[room].id AS RoomsAviable FROM [dbo].[room]
WHERE [dbo].[room].id NOT IN (
	SELECT [dbo].[booking].room_no
	FROM [dbo].[booking]
	WHERE [dbo].[booking].booking_date <= '2016-11-25' AND DATEADD(DAY, [dbo].[booking].nights, [dbo].[booking].booking_date) > '2016-11-25'
)
