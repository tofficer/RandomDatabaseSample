drop view if exists holiday_sales;
create view holiday_sales as
select store, sum(weeklySales) as hol_sales
from hw3.sales 
join hw3.holidays on sales.WeekDate = holidays.WeekDate
where holidays.isHoliday = true 
group by sales.store;

select store, hol_sales
from holiday_sales
where hol_sales = (select min (hol_sales) from holiday_sales) or hol_sales = (select max (hol_sales) from holiday_sales)
order by hol_sales;

TERMINAL OUTPUT

 store |  hol_sales  
-------+-------------
    33 | 2.62594e+06
    20 | 2.24903e+07
(2 rows)

JDBC APP OUTPUT

store 33, hol_sales 2625945
store 20, hol_sales 22490344