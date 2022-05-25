create database tirgol_11;
use  tirgol_11;
Create Table Bursa
(
StockID int NOT NULL,
Name text,
CompanyID int NOT NULL,
Price float NOT NULL,
OptionId int,
PRIMARY KEY(Stockid)
);

Insert into Bursa
Values
(100 , 'TEVA' ,10 , 18900 , Null),
(200 , 'Kur' , 20 , 10050 , Null),
(300 , 'Machteshim' , 30 , 2120 , Null),
(400 , 'Leumi' , 40 , 1080 , 155),
(500 , 'Poalim' , 50 , 1060 , 244),
(600 , 'Strauss' , 60 , 4200 , 366),
(700 , 'Osen' , 70 , 4200 , Null),
(800 , 'Kamada' , 80 , 2970 , 788),
(900 , 'Phonix1' , 90 , 700 , Null),
(1000 , 'Phonix5' , 90 , 2570 , Null),
(1100 , 'DelekRechev' , 100 , 3080 ,Null),
(1200 , 'Elbit' , 110 , 7880 , Null),
(1300 , 'Ormat' , 120 , 3330 , 599);

Create Table Companies
(
CompanyID int NOT NULL,
CompanyName text,
Owner text,
SectorId int NOT NULL,
Markets text,
PRIMARY KEY(CompanyId)
);
Insert into Companies
Values
(10 , 'TEVA' , 'Horovitz' , 111 , 'Dual'),
(20 , 'IDB' , 'Dankner' , 222 , 'Israel'),
(30 , 'MachteshimAgan' , 'Biger' , 333 , 'Israel'),
(40 , 'BankLeumi' , 'Maur' , 444 , 'Israel'),
(50 , 'BankPoalim' , 'Arison' , 444 , 'Israel'),
(60 , 'StraussGroup' , 'Levin' , 555 , 'Dual'),
(70 , 'Osem' , 'Proper' , 555 , 'Israel'),
(80 , 'Kamada' , 'Ralph' , 111 , 'Israel'),
(90 , 'Phonix' , 'Yaheli' , 666 , 'Israel'),
(100 , 'DelekGroup' , 'Agmon' , 777 , 'Israel'),
(110 , 'Elbit' , 'Ziser' , 222 , 'Dual'),
(120 , 'Ormat' , 'Bronitzki' , 888 , 'Dual');

Create Table Sectors
(
SectorID int NOT NULL,
Sector text,
PRIMARY KEY(SectorId)
);
Insert into Sectors
Values
(111 , 'Pharma'),
(222 , 'Holdings'),
(333 , 'Agro'),
(444 , 'Finance'),
(555 , 'Food'),
(666 , 'Insurance'),
(777 , 'Cars'),
(888 , 'Energy');

Create Table Options
(
OptionID int NOT NULL,
Price float,
Exp_Date date,
PRIMARY KEY(OptionId)
);

Insert into Options
Values
(155 , 108 , '10-01-02'),
(244 , 102 , '11-03-04'),
(366 , 480 , '09-08-01'),
(788 , 300 , '10-05-05'),
(599 , 300 , '12-02-01'),
(633 , 270 , '09-12-28'),
(211 , 290 , '09-02-19'),
(511 , 180 , '09-06-13');

alter table bursa rename StocksList;

alter table StocksList rename column Name to StockName;

update StocksList 
set StockName = 'Osem'
where stockid = 700;

create index OptionId_Index
on StocksList(OptionId);

create index CompanyId_Index
on StocksList(CompanyId);

create index SectorId_Index
on Companies(SectorId);

select Sector, count(SectorID) from sectors join companies using (sectorid)
group by sectorid
having count(sectorid) >1;

with NumOfCompanies as (
select distinct sector, count(sectorid) over (partition by sectorid ) NumOfCompa
from sectors join companies using (sectorid)
) 
select * from NumOfCompanies where NumOfCompa > 1;

select CompanyName from companies
where CompanyName in (select StockName from stockslist);

select  StockID,StockName from stockslist
where companyid in (select companyid from companies where CompanyName like '%group%');

select companyname,price from stockslist join companies using (companyid)
where price in (select max(price) from stockslist) or price in (select min(price) from stockslist);

select companyname,stockslist.price StockslistPrice,Options.price OptionsPrice
from companies left join stockslist using (CompanyID) left join options using(optionid);

select if((select count(Markets) from companies where Markets = 'dual') = (select count(Markets) from companies where Markets = 'israel'), 'Equal', 'Not Equal') as dualOrIsrael;

update stockslist
set optionid = round((select (select sectorid from sectors where sectorid = (select sectorid from Companies where companyname = 'MachteshimAgan')))*
(select companyid from companies where companyname = 'MachteshimAgan')/100)
where stockname = 'Machteshim';

insert into Options (OptionID,Price,Exp_date)
values(
(select optionid from stockslist where stockname = 'Machteshim'),
(select floor(price/12) from stockslist where stockname = 'Machteshim'),
(select CURDATE()))
;

select *, case
when optionid in (select optionid from stockslist ) then truncate(price*1.05,2)
when optionid is null then truncate(price*1.1,2) end as NewPrice
from stockslist;

select exp_date,companyname,sector
from 
options left join stockslist using (optionid) left join companies using (companyid) left join sectors using (sectorid);

select stockname from stockslist
where companyid in (select companyid from companies where sectorid = (select sectorid from companies where companyname = 'BankLeumi')) 
and companyid !=  (select companyid from companies where companyname = 'BankLeumi');



select stockname, round(max((stockslist.price)/(options.price)))
from stockslist join options using(optionid);

select sector,exp_date from sectors
join options on 
where sectorid in (select sectorid from companies where companyid in(select companyid from stockslist where OptionId in (select OptionId from options)))