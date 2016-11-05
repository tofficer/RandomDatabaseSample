drop view if exists store_ymq;
create view store_ymq as 
select sales.store, 
extract(year from WeekDate) as yr, 
extract(month from WeekDate) as mo, 
case when extract(month from WeekDate) >= 1 and extract(month from WeekDate) <= 3 then '1' 
when extract(month from WeekDate) >= 4 and extract(month from WeekDate) <= 6 then '2'
when extract(month from WeekDate) >= 7 and extract(month from WeekDate) <= 9 then '3' 
when extract(month from WeekDate) >= 10 and extract(month from WeekDate) <= 12 then '4'
else '' end as qtr, 
stores.type, 
sales.WeeklySales 
from hw3.sales 
join hw3.stores on sales.store = stores.store 
where stores.type = 'A' or stores.type = 'B' 
order by sales.store; 

drop view if exists a_sales; 
create view a_sales as 
select store_ymq.yr, 
store_ymq.qtr, 
sum (store_ymq.weeklySales) as store_a_sales 
from store_ymq 
where store_ymq.type = 'A' 
group by store_ymq.yr, 
store_ymq.qtr
order by store_ymq.yr, 
store_ymq.qtr;

drop view if exists b_sales; 
create view b_sales as 
select store_ymq.yr, 
store_ymq.qtr, 
sum (store_ymq.weeklySales) as store_b_sales 
from store_ymq 
where store_ymq.type = 'B' 
group by store_ymq.yr, 
store_ymq.qtr
order by store_ymq.yr, 
store_ymq.qtr;

drop view if exists y1;
create view y1 as
select a_sales.yr as yr, a_sales.qtr as qtr, a_sales.store_a_sales as a_sales, b_sales.store_b_sales as b_sales
from a_sales 
join b_sales on a_sales.yr = b_sales.yr and a_sales.qtr = b_sales.qtr;

drop view if exists z1;
create view z1 as
select yr, sum(a_sales) as a_sales, sum(b_sales) as b_sales
from y1
group by yr;

select * from (select yr, qtr, a_sales, b_sales from y1 UNION ALL select yr, NULL AS qtr, a_sales, b_sales from z1) as foo;

  yr  | qtr |   a_sales   |   b_sales   
------+-----+-------------+-------------
 2010 | 1   | 2.38155e+08 | 1.11852e+08
 2010 | 2   | 3.90789e+08 |  1.8321e+08
 2010 | 3   | 3.82693e+08 | 1.78504e+08
 2010 | 4   | 4.53791e+08 | 2.16413e+08
 2011 | 1   | 3.41851e+08 | 1.53904e+08
 2011 | 2   | 3.85808e+08 | 1.75556e+08
 2011 | 3   | 4.13364e+08 | 1.87497e+08
 2011 | 4   | 4.37185e+08 | 2.07162e+08
 2012 | 1   | 3.81453e+08 |   1.725e+08
 2012 | 2   | 3.98116e+08 | 1.81932e+08
 2012 | 3   | 3.89167e+08 | 1.78201e+08
 2012 | 4   |  1.1864e+08 | 5.39715e+07
 2010 |     | 1.46543e+09 | 6.89978e+08
 2011 |     | 1.57821e+09 | 7.24119e+08
 2012 |     | 1.28738e+09 | 5.86605e+08
(15 rows)


