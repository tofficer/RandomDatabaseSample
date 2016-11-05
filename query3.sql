drop view if exists holiday_sales;
create view holiday_sales as 
select holidays.WeekDate, holidays.IsHoliday, sum (sales.WeeklySales) as AllSales 
from hw3.sales, hw3.holidays 
where sales.WeekDate = holidays.WeekDate 
group by holidays.WeekDate, holidays.IsHoliday;

select count(*) 
from holiday_sales 
where IsHoliday = false and AllSales > ( 
select avg (AllSales) 
from holiday_sales 
where IsHoliday = true
);

 count 
-------
     8
(1 row)

JDBC APP OUTPUT
count 8