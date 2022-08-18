USE [GuestHouse2020]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [New Hire]    Script Date: 16/11/2021 5:22:01 PM ******/
CREATE LOGIN [New Hire] WITH PASSWORD=N'K6bB1JJkGHdLZckZAo720sB2GCfdBzKqkek8QmT1Raw=', 
DEFAULT_DATABASE=[master], 
DEFAULT_LANGUAGE=[us_english], 
CHECK_EXPIRATION=OFF, 
CHECK_POLICY=ON
GO

ALTER LOGIN [New Hire] DISABLE
GO

CREATE ROLE [newHireRole]
GO

ALTER ROLE [newHireRole] ADD MEMBER [New Hire]
GO

GRANT SELECT ON [dbo].[V_total_payable_Andrew] TO [newHireRole]
GO

GRANT SELECT ON [dbo].[V_lists_of_guests] TO [newHireRole]
GO

GRANT SELECT ON [dbo].[V_total_payable] TO [newHireRole]
GO

EXECUTE AS LOGIN='New Hire'
GO

SELECT * FROM [dbo].[V_total_payable_Andrew]
GO
SELECT * FROM [dbo].[V_lists_of_guests]
GO
SELECT * FROM [dbo].[V_total_payable]
GO

SELECT * FROM booking
GO

REVERT