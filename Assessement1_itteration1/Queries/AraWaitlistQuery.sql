USE [AraWaitlist]
GO

---TABLE DROPS----
DROP TABLE [dbo].[Patient]
DROP TABLE [dbo].[Surgeon]
DROP TABLE [dbo].[Refferer]
DROP TABLE [dbo].[Refferal]
--DROP TABLE 


---CREATING PATIENT TABLE
CREATE TABLE Patient(
patientID INT IDENTITY(1,1) PRIMARY KEY,
NHI VARCHAR(7),
firstName VARCHAR(25),
lastName VARCHAR(25),
DOB DATE,
gender VARCHAR(15)
)


---CREATING SURGEON TABLE
CREATE TABLE Surgeon(
surgeonId INT IDENTITY(1,1) PRIMARY KEY,
firstName VARCHAR(25),
lastName VARCHAR(25),
department VARCHAR(25)
)


---CREATING REFFERER TABLE
CREATE TABLE Refferer(
reffererID INT IDENTITY(1,1) PRIMARY KEY,
firstName VARCHAR(25),
lastName VARCHAR(25) ,
)


CREATE TABLE Refferal(
refferalCode INT IDENTITY(1,1) PRIMARY KEY,

surgeonID INT,
FOREIGN KEY (surgeonID) REFERENCES [dbo].[Surgeon](surgeonID),

patientID INT,
FOREIGN KEY (patientID) REFERENCES [dbo].[Patient](patientID),


reffererID INT,
FOREIGN KEY (reffererID) REFERENCES [dbo].[Refferer](reffererID),

refferalDate Date,
refferedFrom VARCHAR(25),
fsaDate DATE
)

