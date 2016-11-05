drop view if exists month_type;
drop view if exists type_sum;

create view month_type as 
select substr( cast (sales.WeekDate as text), 6, 2) as month, stores.type, sum (sales.WeeklySales) as sumByMonthAndType
from hw3.sales
join hw3.stores on stores.store = sales.store
group by month, stores.type
order by stores.type;

create view type_sum as 
select type, sum (sumByMonthAndType) as sumByType
from month_type 
group by type;

select month_type.month, month_type.type, month_type.sumByMonthAndType as sum, (month_type.sumByMonthAndType / type_sum.sumByType * 100) as percentContribution
from month_type, type_sum 
where month_type.type = type_sum.type
order by month_type.type, month_type.month;

month | type |     sum     | percentcontribution 
-------+------+-------------+---------------------
 01    | A    | 2.14176e+08 |    4.94517274200916
 02    | A    | 3.66506e+08 |    8.46237763762474
 03    | A    | 3.80773e+08 |      8.791783452034
 04    | A    | 4.16181e+08 |    9.60933044552803
 05    | A    | 3.59085e+08 |    8.29102694988251
 06    | A    | 3.99448e+08 |    9.22297462821007
 07    | A    | 4.17243e+08 |    9.63384658098221
 08    | A    | 3.94862e+08 |      9.117092192173
 09    | A    | 3.73119e+08 |    8.61504897475243
 10    | A    | 3.77133e+08 |    8.70773121714592
 11    | A    | 2.64721e+08 |    6.11222237348557
 12    | A    | 3.67763e+08 |    8.49139615893364
 01    | B    | 9.54465e+07 |    4.77065369486809
 02    | B    | 1.67672e+08 |    8.38064625859261
 03    | B    | 1.75136e+08 |     8.7537482380867
 04    | B    |  1.9088e+08 |    9.54067409038544
 05    | B    | 1.63456e+08 |    8.16993340849876
 06    | B    | 1.86362e+08 |    9.31484028697014
 07    | B    | 1.93743e+08 |    9.68378409743309
 08    | B    | 1.81505e+08 |     9.0720571577549
 09    | B    | 1.68954e+08 |     8.4447517991066
 10    | B    | 1.70604e+08 |    8.52721557021141
 11    | B    | 1.25546e+08 |    6.27508610486984
 12    | B    | 1.81396e+08 |    9.06661078333855
 01    | C    | 2.29758e+07 |    5.66600374877453
 02    | C    | 3.45485e+07 |    8.51990282535553
 03    | C    | 3.68753e+07 |    9.09371897578239
 04    | C    | 3.97991e+07 |    9.81473177671432
 05    | C    | 3.45833e+07 |    8.52850154042244
 06    | C    | 3.68194e+07 |    9.07992497086525
 07    | C    | 3.90144e+07 |    9.62123945355415
 08    | C    | 3.67215e+07 |     9.0557835996151
 09    | C    | 3.66885e+07 |    9.04765650629997
 10    | C    | 3.70491e+07 |    9.13656130433083
 11    | C    | 2.27486e+07 |    5.60997538268566
 12    | C    | 2.76796e+07 |    6.82599917054176
(36 rows)


JDBC APP OUTPUT
month 03, type A, sum 3.8077302e+08, percentcontribution 8.7917834520339966
month 04, type A, sum 4.1618106e+08, percentcontribution 9.6093304455280304
month 10, type A, sum 3.771327e+08, percentcontribution 8.7077312171459198
month 05, type B, sum 1.6345584e+08, percentcontribution 8.169933408498764
month 07, type B, sum 1.9374344e+08, percentcontribution 9.6837840974330902
month 09, type B, sum 1.6895413e+08, percentcontribution 8.4447517991065979
month 12, type B, sum 1.8139566e+08, percentcontribution 9.0666107833385468
month 05, type C, sum 34583348, percentcontribution 8.5285015404224396
month 07, type C, sum 39014436, percentcontribution 9.6212394535541534
month 09, type C, sum 36688540, percentcontribution 9.0476565062999725
