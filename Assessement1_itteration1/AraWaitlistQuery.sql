USE [AraWaitlist]
GO

CREATE TABLE Patient(
NHI VARCHAR(7) PRIMARY KEY NOT NULL,
firstName VARCHAR(25) NOT NULL,
lastName VARCHAR(25) NOT NULL,
DOB DATE NOT NULL,
gender CHAR(1) NOT NULL
)
-- INSERT DATA INTO TABLE
INSERT INTO [dbo].[Patient] VALUES('QDX4955', 'Spense', 'Pringuer', '14-Feb-1972', 'M')