USE [GuestHouse2020]
GO

--DROP VIEW 

SET STATISTICS IO ON;
GO

SET STATISTICS TIME ON;
GO

--CREATE CLUSTERED INDEX IX_Guest_Name
--ON lists_of_guests([first_name], [address])
--GO

--1. A list of all Rooms with description.
CREATE OR ALTER VIEW V_list_of_rooms AS 
SELECT [dbo].[room].room_type
FROM [dbo].[room]
GO

SELECT * FROM V_list_of_rooms
GO

--2. A list of Guests with their name concatenated and address.
CREATE OR ALTER VIEW V_lists_of_guests AS 
SELECT [dbo].[guest].first_name + ' ' + [dbo].[guest].last_name AS 'Guest Name', [dbo].[guest].address
FROM [dbo].[guest]
GO

SELECT * FROM V_lists_of_guests
GO

--3. Show the date of check in and check out and number of nights for booking 5204.
CREATE OR ALTER VIEW V_booking_info_5204 AS
SELECT [dbo].[booking].booking_id, [dbo].[booking].booking_date AS 'Checkin Date',  DATEADD(DAY,[dbo].[booking].nights, [dbo].[booking].booking_date) AS 'Checkout Date'
FROM [dbo].[booking]
WHERE [dbo].[booking].booking_id = 5204
GO

SELECT * FROM V_booking_info_5204
GO

--4. List all the people and their room number, who made the booking for room on 26th Nov
--2016. 
CREATE OR ALTER VIEW V_list_of_bookings_26Nov AS
SELECT [dbo].[guest].first_name + ' ' + [dbo].[guest].last_name AS 'Guest Name', [dbo].[booking].room_no
FROM [dbo].[guest]
INNER JOIN [dbo].[booking] on [dbo].[booking].guest_id=[dbo].[guest].id
WHERE [dbo].[booking].booking_date = '2016-11-26'
GO

SELECT * FROM V_list_of_bookings_26Nov
GO

--5. List the people who made the booking for room number 209 on 26th Nov 2016
CREATE OR ALTER VIEW V_list_of_people_bookings_26Nov AS
SELECT [dbo].[guest].first_name + ' ' + [dbo].[guest].last_name AS 'Guest Name', [dbo].[booking].room_no, [dbo].[booking].booking_date
FROM [dbo].[guest]
INNER JOIN [dbo].[booking] on [dbo].[booking].guest_id=[dbo].[guest].id
WHERE [dbo].[booking].booking_date = '2016-11-26' and [dbo].[booking].room_no = 209
GO

SELECT * FROM V_list_of_people_bookings_26Nov
GO

--6. Show the name of the guest, occupants, date of check in and check out and number of
--nights for booking 5046.
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

--7. Calculate the total bill for booking 5128 including extras.
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

--8. Show the total amount payable by guest Dr Andrew Murrison for his room bookings. You
--should JOIN to the rate table using room_type_requested and occupants.
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

--9. Show the total amount payable by guest who has a ‘Sir’ prefix, whose first name starts
--with ‘P’ and last name ends with ‘rd’ for his room bookings.
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

--10. For every guest who has the word “East” in their address show the total number of nights
--booked. Be sure to include 0 for those guests who have never had a booking. Show last
--, first name, address and number of nights. Order by last name then first name
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