
create table calendar (id int, start timestamp, end timestamp);
insert into calendar values 
(1, '2019-10-23 08:50:06.000', '2019-10-23 09:10:06.000'),
(2, '2019-10-23 09:15:06.000', '2019-10-23 09:40:06.000'),
(3, '2019-10-23 09:30:06.000', '2019-10-23 09:50:06.000'),
(4, '2019-10-23 10:30:06.000', '2019-10-23 10:40:06.000');

with sample as(
select * from calendar)


-- דרך פתרון 1 -- 

select end as first_time_to_meet, timestampdiff(minute,tbl1.end,next_meet) as available_time
from(
select id, end,lead(start) over (order by id) as next_meet from sample) as tbl1

where timestampdiff(minute,tbl1.end,next_meet) >= 40
order by id desc
limit 1;





-- דרך פתרון 2 --

select
concat('after meeting num ', id),
tbl1.end as time_to_start, 
case 
when (timestampdiff(minute,tbl1.end,next_meet)) >=40 
then concat('You have ', timestampdiff(minute,tbl1.end,next_meet), ' minutes to meet')
else 'You have no time to meet'  end as time_to

from (select id, end,lead(start) over (order by id) as next_meet from calendar) as tbl1
order by (timestampdiff(minute,tbl1.end,next_meet)) desc;
