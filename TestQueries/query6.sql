drop table if exists AvgSales;
create table averages as select avg (WeeklySales) from hw3.sales;

drop table if exists averages;
create table averages as 
  select avg (sales.WeeklySales) as AvgSales,
         avg (temporalData.Temperature) as AvgTemp,
         avg (temporalData.FuelPrice) as AvgFuel,
         avg (temporalData.CPI) as AvgCPI,
         avg (temporalData.UnemploymentRate) as AvgUnemp
  from hw3.sales, hw3.temporalData
  where sales.store = temporalData.store and sales.WeekDate = temporalData.WeekDate;

drop table if exists output7;
create table output7 (attribute varchar(20), corr_sign varchar(1), correlation real);

insert into output7 values ('Temperature', '', 0),
       ('FuelPrice', '', 0), ('CPI', '', 0), ('UnemploymentRate', '', 0);

update output7 set correlation = (
  select corr (temporalData.Temperature, sales.WeeklySales) 
  from hw3.sales, hw3.temporalData
  where sales.store = temporalData.store and sales.WeekDate = temporalData.WeekDate)
where attribute = 'Temperature';

update output7 set correlation = (
  select corr (temporalData.FuelPrice, sales.WeeklySales) 
  from hw3.sales, hw3.temporalData
  where sales.store = temporalData.store and sales.WeekDate = temporalData.WeekDate)
where attribute = 'FuelPrice';

update output7 SET correlation = (
  select corr (temporalData.CPI, sales.WeeklySales) 
  from hw3.sales, hw3.temporalData
  where sales.store = temporalData.store and sales.WeekDate = temporalData.WeekDate)
where attribute = 'CPI';

update output7 set correlation = (
  select corr (temporalData.UnemploymentRate, sales.WeeklySales) 
  from hw3.sales, hw3.temporalData
  where sales.store = temporalData.store and sales.WeekDate = temporalData.WeekDate)
where attribute = 'UnemploymentRate';

update output7 set corr_sign = case when correlation < 0 then '-' when correlation  > 0 then '+' else '' end;

select * from output7;

    attribute     | corr_sign | correlation  
------------------+-----------+--------------
 Temperature      | -         |  -0.00231245
 FuelPrice        | -         | -0.000120296
 CPI              | -         |   -0.0209213
 UnemploymentRate | -         |   -0.0258637
(4 rows)



JDBC APP output
attibute Temperature, corr_sign -, correlation -0.00231245
attibute FuelPrice, corr_sign -, correlation -0.000120296
attibute CPI, corr_sign -, correlation -0.0209213
attibute UnemploymentRate, corr_sign -, correlation -0.0258637
