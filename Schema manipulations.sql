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

-- 1.1

ALTER TABLE bursa RENAME StocksList;

-- 1.2

ALTER TABLE StocksList 
RENAME column Name TO StockName;

UPDATE StocksList 
SET StockName = 'Osem'
WHERE StockID = 700;

SELECT * FROM StocksList;



-- 1.3 Indexes Creation

CREATE INDEX StocksList_OptionId
ON StocksList(OptionId);

CREATE INDEX StocksList_CompanyId
ON StocksList(CompanyId);

CREATE INDEX Companies_SectorId
ON Companies(SectorId);


-- Show the names of the sectors in which there is more than one company, for each sector show the number of existing companies at him.



select Sectorid ,num_of_companies

from Sectors left join 
(select SectorID, count(SectorID) as num_of_companies from companies group by SectorID having count(SectorID) > 1) as sector_agg using(SectorID)

where SectorID in (select SectorID from companies group by SectorID having count(SectorID) > 1);

-- Present a list of the names of the companies in which the share name is the same as the name of the company itself



select companyname from companies
where CompanyName in (select StockName from stockslist);



-- Extract the stock names and stock numbers for companies that are 'holding groups' (whose name contains the word Group)

select stockid,stockname from stockslist
where companyid in 
(select companyid from companies where companyname like '%Group%');



-- Find the cheapest and most expensive stock price and for them present the company name.

select companyname from companies
where companyid in (select companyid from stockslist where price in 
(
(select max(Price) from stockslist)
union
(select min(Price) from stockslist)
));


-- Show all available information for the following table (company name, share price, option price), do this by performing Combinations between the various tables
--  If there are shares that do not have a share price or option - save information according to The need.


SELECT companyname, stockslist.price as Stock_Price, Options.price as Option_Price  from 
companies left join stockslist using (companyid) left join options using (OptionID);

-- Is the number of dual companies equal to the number of existing Israeli companies in the membership table


SELECT 	case 
			when ((select count(*) from Companies where Markets = 'dual') = (select count(*) from Companies where Markets = 'Israel'))
			then 'the number of dual companies equal to the number of existing Israeli companies'
            else 'the number of dual companies is not equal to the number of existing Israeli companies'
            end as dual_equal_Israeli;
            

/*  
The Securities Authority has decided to allocate a new option to Makhteshim, in light of which the updates must be madeThe following 

1. Update the Makhteshim option code in the share table (the option code is equal to the sector code multiplied by the company codeParts 100)
The result should be rounded to the nearest value.

2. Adding a new row to an options table containing the following 3 details:
	A. Option code - as listed in the stock table
	B. Option price - equal to the share price divided by 12 (The digits after the dot can be ignored Decimal)
	C. expiration date - date of the day 
*/

-- 1

update stockslist set
OptionID = round((select SectorID*CompanyID from companies where CompanyName = 'MachteshimAgan')/100)
where stockName = 'Machteshim';


-- 2.A

Insert into Options
Values
(
(select OptionID from stockslist where stockname = 'Machteshim'),
(select TRUNCATE((price/12),0) from stockslist where stockname = 'Machteshim'),
(Select CURDATE() from stockslist limit 1)
);

select * from stockslist;
select * from Options;




/* 
The stock price of the stocks that have no options has risen by 10% in the last week while the stock prices for the stocks
That have options increased by only 5% - show a table showing the names of the shares and the new prices after
Performing the above increases (In this question there is no need to update the data)
*/
    
    
select stockname, case 
						when OptionID is null then round(price*1.1)
                        else round(price*1.05)
                        end as stocks_new_price
from stockslist;



/* 
For each option present the following data (Make sure to save information if necessary)
	i. Expiration date of the option
	ii. Name of the company that issued this option.
	iii. The name of the sector to which this company belongs.
*/ 

select Options.Exp_date, companies.CompanyName, Sectors.Sector 
from Options 
join stockslist using(OptionID);

/*
Present the names of the shares in the sector to which Bank Leumi's option belongs
*/


select stockname from stockslist
where CompanyID in 
(select CompanyID from Companies where SectorID =
(select SectorID from companies where companyid = 
(select companyid from stockslist where OptionID = 
(select OptionID from stockslist where stockname = 'Leumi'))));

/* Find out which of all the existing stocks and options has the highest ratio 
(Who has the maximum value of 'Share price' divided by 'Option price') */

select stockname,max(round(stockslist.price/options.price)) as max_price from
stockslist join options using(optionid);



-- View the expiration date of all options in the sectors: Pharma, Finance, Food and Insurance.

select Exp_date from Options
where optionid in 
(select optionid from stockslist where  companyid in
(select companyid from companies where SectorID in
(select sectorid from sectors where sector in ('Pharma','Finance' ,'Food' , 'Insurance'))));




-- What is the name of the sector where the number of Israeli companies is the highest


select sector from sectors
where sectorid = 
(select sectorid from Companies
where Markets = 'Israel'
group by sectorid 
having count(Markets)
order by count(Markets) desc 
limit 1)









    