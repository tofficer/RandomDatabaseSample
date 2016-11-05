drop view if exists v10; 
create view v10 as 
select sales.dept, sales.store, sum(WeeklySales)/(stores.size) as norm 
from hw3.sales 
join hw3.stores on sales.store = stores.store 
group by sales.dept, sales.store, stores.size; 

select dept, sum(norm) as NormSales 
from v10
group by dept 
order by NormSales desc 
fetch first 10 rows only;

 dept |    normsales     
------+------------------
   92 | 4128.35286278814
   38 | 4080.21100678578
   95 | 3879.83506743269
   90 | 2567.52595662948
   40 |  2400.3481441157
    2 | 2232.72932645926
   72 | 2191.77407134551
   91 | 1791.72811012717
   94 | 1747.77822848924
   13 | 1620.50958560205
(10 rows)


JDBC APP OUTPUT
dept 92, normsales 4128.3528627881415
dept 38, normsales 4080.2110067857752
dept 95, normsales 3879.8350674326948
dept 90, normsales 2567.525956629479
dept 40, normsales 2400.3481441156973
dept 2, normsales 2232.7293264592604
dept 72, normsales 2191.774071345505
dept 91, normsales 1791.728110127171
dept 94, normsales 1747.7782284892407
dept 13, normsales 1620.5095856020475
