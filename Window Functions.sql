use tirgol_10;

-- בחירת מקסימום גיל לכל שנה

select *, 
max(age) over (partition by year) as top_age_in_dep from students;

--  מספור שורות לכל מחלקה

select *,
row_number() over (partition by year order by age desc) as rownumber
from students;

--   שני העובדים המבוגרים ביותר בכל מחלקה בכל שנה

select * from (
select *,
row_number() over (partition by year order by age desc) as rownumber
from students) as x
where x.rownumber <3;


select *,
dense_rank() over (partition by year order by age desc)  as rnk
from students;

-- מציאת ערך עוקב או ערך מקדים לאג - ליד

select *,
lag(age) over (partition by year order by age desc)  prev_age
from students;

select *,
lead(age) over (partition by year order by age desc)  next_age
from students;


-- Runing total - order by is a must value

select *,
sum(age) over ( partition by year order by age) as runn
from students;

-- first value - the yungest in every department

select *,
first_value(name) over (partition by year order by age) 
from students;

-- last value - the yungest in every department

select *,
last_value(name) over (partition by year order by age desc range between unbounded preceding and unbounded following ) 
from students;


-- ntile - use to group tougether in buckets 

select *,
ntile(3) over (order by age desc) 
from students;


-- cume_dist 

select *,
cume_dist() over (order by age desc) as cume_dist_age
from students;
 

-- cume_dist  in precenntage

select *,
round(cume_dist() over (order by age desc)*100,2) as cume_dist_age
from students;

-- cume_dist  in precenntage

select name, (cume_dist_age) as cume_dist_in_precennt
from (
select *,
round(cume_dist() over (order by age desc)*100,2) as cume_dist_age
from students) as x;


 --  precennt rank

select *,
present_rank() over (order by price)
round(cume_dist() over (order by age desc)*100,2) as cume_dist_age
from students) as x;





