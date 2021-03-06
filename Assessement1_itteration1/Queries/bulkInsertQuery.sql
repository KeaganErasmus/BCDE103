USE [AraWaitlist]
GO

---Patient data
BULK INSERT [dbo].[Patient]
from 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\CSVs\Patient.csv'
 WITH
      (
	     FIRSTROW=2,
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n'
      );

---Surgeon data
BULK INSERT [dbo].[Surgeon]
from 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\CSVs\Surgeon.csv'
 WITH
      (
		 FIRSTROW=2,
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n'
      );


---Refferer data
BULK INSERT [dbo].[Refferer]
from 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\CSVs\Refferer.csv'
 WITH
      (
		 FIRSTROW=2,
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n'
      );

BULK INSERT [dbo].[Refferal]
from 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\CSVs\Refferal.csv'
 WITH
      (
		 FIRSTROW=2,
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n',
      );

load data infile 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\CSVs\Refferal.csv'
into table [dbo].[Refferal]
FIRSTROW=2,
fields terminated by ',',
lines terminated by '\n',
(refferalCode, surgeonID, patientID, reffererID, refferalDate, refferedFrom, fsaDate);
