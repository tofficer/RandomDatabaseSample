select distinct store 
from hw3.temporalData 
where temporalData.UnemploymentRate > 10.0
except 
select distinct store 
from hw3.temporalData 
where temporalData.FuelPrice > 4;

 store 
-------
    34
    43
(2 rows)

JDBC APP OUTPUT
store 34
store 43
