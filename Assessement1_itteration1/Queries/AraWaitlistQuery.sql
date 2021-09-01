USE [AraWaitlist]
GO

---TABLE DROPS----
DROP TABLE [dbo].[Patient]
DROP TABLE [dbo].[Surgeon]
DROP TABLE [dbo].[Refferer]
DROP TABLE [dbo].[FSA]
DROP TABLE [dbo].[Refferal]
--DROP TABLE 



---CREATING PATIENT TABLE
CREATE TABLE Patient(
patientID INT IDENTITY(1,1) PRIMARY KEY,
NHI VARCHAR(7) NOT NULL,
firstName VARCHAR(25) NOT NULL,
lastName VARCHAR(25) NOT NULL,
DOB DATE NOT NULL,
gender CHAR(15) NOT NULL
)


---CREATING SURGEON TABLE
CREATE TABLE Surgeon(
surgeonId INT IDENTITY(1,1) PRIMARY KEY,
fsaID INT FOREIGN KEY (fsaID) REFERENCES [dbo].[FSA](fsaID),
firstName VARCHAR(25) NOT NULL,
lastName VARCHAR(25) NOT NULL,
department VARCHAR(25) NOT NULL
)


---CREATING REFFERER TABLE
CREATE TABLE Refferer(
reffererID INT IDENTITY(1,1) PRIMARY KEY,
surgeonId INT FOREIGN KEY (surgeonId) REFERENCES [dbo].[Surgeon](surgeonId),
firstName VARCHAR(25),
lastName VARCHAR(25) ,
)


CREATE TABLE Refferal(
refferalCode INT IDENTITY(1,1) PRIMARY KEY,

patientID INT,
FOREIGN KEY (patientID) REFERENCES [dbo].[Patient](patientID),

surgeonID INT,
FOREIGN KEY (surgeonID) REFERENCES [dbo].[Surgeon](surgeonID),

refferalDate Date NOT NULL,
refferedFrom VARCHAR(25) NOT NULL
)

CREATE TABLE FSA(
fsaID INT IDENTITY(1,1) PRIMARY KEY,
fsaDate DATE,
)
