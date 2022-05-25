
create database yam_analytics_quastions;
use yam_analytics_quastions;

create table Orders
(ORDER_TIME_STAMP timestamp,	ORDER_DATE date,	ORDER_DATE_HOUR datetime,	AVG_UNIT_PRICE float,	SUM_ORDER float,	ITEM_ORDERS int,	COUNTRY text,	CUSTOMER_ID int,	ORDER_ID int);



insert into Orders 
 values
('2010-12-01 09:53:00',	'2010-12-01',	'2010-12-01 9:53',	4.7807691831,	489.5999960899,		13,	'United Kingdom',	18074,	536384),
('2010-12-01 10:51:00',	'2010-12-01',	'2010-12-01 10:51',	4.6500000954,	279.000005722,		2,	'United Kingdom',	17924,	536397),
('2010-12-01 09:01:00',	'2010-12-01',	'2010-12-01 9:01',	1.8500000238,	22.2000002861,		2,	'United Kingdom',	17850,	536372),
('2010-12-01 09:02:00',	'2010-12-01',	'2010-12-01 9:02',	3.3193749636,	259.8599972725,		16,	'United Kingdom',	17850,	536373),
('2010-12-01 09:32:00',	'2010-12-01',	'2010-12-01 9:32',	3.3193749636,	259.8599972725,		16,	'United Kingdom',	17850,	536375),
('2010-12-01 09:34:00',	'2010-12-01',	'2010-12-01 9:34',	1.8500000238,	22.2000002861,		2,	'United Kingdom',	17850,	536377),
('2010-12-01 10:51:00',	'2010-12-01',	'2010-12-01 10:51',	5.2116666238,	376.359995842,		18,	'United Kingdom',	17850,	536396),
('2010-12-01 09:41:00',	'2010-12-01',	'2010-12-01 9:41',	1.4500000477,	34.8000011444,		1,	'United Kingdom',	17809,	536380),
('2010-12-01 10:19:00',	'2010-12-01',	'2010-12-01 10:19',	2.4529166635,	1825.7399904728,	24,	'United Kingdom',	17511,	536390),
('2010-12-01 09:56:00',	'2010-12-01',	'2010-12-01 9:56',	5.5714286906,	130.8500015736,		7,	'United Kingdom',	17420,	536385),
('2010-12-01 09:59:00',	'2010-12-01',	'2010-12-01 9:59',	3.3764285211,	226.1399983168,		14,	'United Kingdom',	16250,	536388),
('2010-12-01 09:45:00',	'2010-12-01',	'2010-12-01 9:45',	5.9708333512,	430.6000010967,		12,	'United Kingdom',	16098,	536382),
('2010-12-01 09:57:00',	'2010-12-01',	'2010-12-01 9:57',	2.7499999205,	508.1999883652,		3,	'United Kingdom',	16029,	536386),
('2010-12-01 09:58:00',	'2010-12-01',	'2010-12-01 9:58',	2.6519999504,	3193.9199638367,	5,	'United Kingdom',	16029,	536387),
('2010-12-01 09:41:00',	'2010-12-01',	'2010-12-01 9:41',	2.5199999877,	449.9799970388,		35,	'United Kingdom',	15311,	536381),
('2010-12-01 09:32:00',	'2010-12-01',	'2010-12-01 9:32',	3,				328.7999992371,		2,	'United Kingdom',	15291,	536376),
('2010-12-01 09:09:00',	'2010-12-01',	'2010-12-01 9:09',	10.9499998093,	350.3999938965,		1,	'United Kingdom',	15100,	536374),
('2010-12-01 09:37:00',	'2010-12-01',	'2010-12-01 9:37',	1.7552631701,	444.9800012112,		19,	'United Kingdom',	14688,	536378),
('2010-12-01 10:47:00',	'2010-12-01',	'2010-12-01 10:47',	2.5707142821,	507.8799939156,		14,	'United Kingdom',	13767,	536395),
('2010-12-01 09:00:00',	'2010-12-01',	'2010-12-01 9:00',	2.5499999523,	203.9999961853,		1,	'United Kingdom',	13748,	536371),
('2010-12-01 10:37:00',	'2010-12-01',	'2010-12-01 10:37',	9.9499998093,	79.5999984741,		1,	'United Kingdom',	13747,	536393),
('2010-12-01 10:29:00',	'2010-12-01',	'2010-12-01 10:29',	18.398999989,	318.1399998665,		10,	'United Kingdom',	13705,	536392),
('2010-12-01 10:39:00',	'2010-12-01',	'2010-12-01 10:39',	2.1881817931,	1024.6800034046,	11,	'United Kingdom',	13408,	536394),
('2010-12-01 08:35:00',	'2010-12-01',	'2010-12-01 8:35',	5.9499998093,	17.8499994278,		1,	'United Kingdom',	13047,	536369),
('2010-12-01 08:45:00',	'2010-12-01',	'2010-12-01 8:45',	2.764500013,	855.8600058556,		20,	'France',			12583,	536370),
('2010-12-01 10:03:00',	'2010-12-01',	'2010-12-01 10:03',	5.2785713673,	358.2499952316,		14,	'Australia',		12431,	536389);












--     יש לסנן לקוחות שרכשו רק פעם אחת כי הם אינם לקוחות חוזרים. אנא חשבו את ממוצע וסטיית התקן של הימים שעברו בין הרכישות של כל לקוח.   שימו לב:    יש לסנן את ההזמנות שסכומם קטן מ 0 (אלו החזרים ולא הזמנות).   




with cte_time_between_orders as
(
select tbl.*, timestampdiff(minute,last_order,ORDER_TIME_STAMP) as time_elapsed
from (

select 
ORDER_TIME_STAMP,lag(ORDER_TIME_STAMP) over(partition by customer_id order by order_date asc) as last_order,
count(order_id) over (partition by customer_id) as customer_orders,
customer_id
from orders) as tbl
where last_order is not null
)

select distinct(customer_id),
customer_orders,
avg(time_elapsed) over(partition by customer_id) as avg_min_between_orders,
std(time_elapsed) over(partition by customer_id) as std_in_min_between_orders

from cte_time_between_orders
order by customer_orders desc;


-- 
select * from orders
where customer_id = 55555;



with cte_time_between_orders as
(
select tbl.*, timestampdiff(day,last_order,ORDER_TIME_STAMP) as time_elapsed
from (

select 
ORDER_TIME_STAMP,lag(ORDER_TIME_STAMP) over(partition by customer_id order by order_date asc) as last_order,
count(order_id) over (partition by customer_id) as customer_orders,
customer_id
from orders) as tbl
where last_order is not null
)


select
distinct(customer_id),
customer_orders,
avg(time_elapsed) over(partition by customer_id) as avg_min_between_orders,
std(time_elapsed) over(partition by customer_id) as std_in_min_between_orders

from cte_time_between_orders
order by customer_orders desc;