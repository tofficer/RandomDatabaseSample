drop view if exists sales_store_dept;
create view sales_store_dept as 
select store, dept, sum (WeeklySales) as SalesStoreDept 
from hw3.sales 
group by store, dept;

drop view if exists sales_store;
create view sales_store as 
select store, sum (WeeklySales) as SalesStore 
from hw3.sales 
group by store;

drop view if exists contributions; 
create view contributions as 
select sales_store_dept.dept, sales_store_dept.store, ((SalesStoreDept / SalesStore) * 100) as percentContribution 
from sales_store_dept 
join sales_store on sales_store_dept.store = sales_store.store;

drop view if exists significant_contributions; 
create view significant_contributions as 
select dept, store, percentContribution 
from contributions
where percentContribution >= 5; 

drop view if exists sig_contribution_count;
create view sig_contribution_count as  
select dept, count (*) as NumStores
from significant_contributions 
group by dept;

drop view if exists depts_significant_contributions; 
create view depts_significant_contributions as 
select dept from sig_contribution_count where NumStores >= 3; 

select contributions.dept, avg (contributions.percentContribution / 100) as avg 
from contributions 
join depts_significant_contributions on contributions.dept = depts_significant_contributions.dept 
group by contributions.dept; 

 dept |        avg         
------+--------------------
    2 | 0.0410644333395693
   38 | 0.0727544868985812
   40 | 0.0441973276022408
   72 | 0.0420093366708089
   90 |  0.044952085107151
   91 | 0.0313700059687512
   92 | 0.0730967512147294
   93 | 0.0254024091054592
   94 | 0.0304081375555446
   95 | 0.0695251010358334
(10 rows)


JDBC APP OUTPUT

dept 2, avg 0.0410644333395693
dept 38, avg 0.0727544868985812
dept 40, avg 0.0441973276022408
dept 72, avg 0.0420093366708089
dept 90, avg 0.044952085107151
dept 91, avg 0.0313700059687512
dept 92, avg 0.0730967512147294
dept 93, avg 0.0254024091054592
dept 94, avg 0.0304081375555446
dept 95, avg 0.0695251010358334

