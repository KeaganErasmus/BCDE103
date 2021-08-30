USE [AraWaitlist]
GO

---Patient data
BULK INSERT [dbo].[Patient]
from 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\Patient.csv'
 WITH
      (
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n'
      );

---Surgeon data
BULK INSERT [dbo].[Surgeon]
from 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\Surgeon.csv'
 WITH
      (
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n'
      );

---Refferer data
BULK INSERT [dbo].[Refferer]
from 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\Refferer.csv'
 WITH
      (
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n'
      );