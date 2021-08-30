BULK INSERT [dbo].[Patient]
from 'C:\Users\keagan\OneDrive\Documents\GitHub\BCDE103\Assessement1_itteration1\Patient.csv'
 WITH
      (
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n'
      );