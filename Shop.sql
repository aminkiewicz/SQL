create database Shop;

use Shop;
?
create table SALES1 
(Store VARCHAR(20) NOT NULL,
    Week VARCHAR(20) NOT NULL,
    Day VARCHAR(20) NOT NULL,
    SalesPerson VARCHAR(20) NOT NULL,
    SalesAmount DECIMAL(6, 2) NOT NULL,
    Month VARCHAR(20) NULL); 

insert into  SALES1
(Store, Week, Day, SalesPerson, SalesAmount, Month) 
values 
('London', '2', 'Monday', 'Frank', 56.25 , 'May'),
('London', '5', 'Tuesday', 'Frank', 74.32 , 'Sep'),
('London', '5', 'Monday', 'Bill', 98.42 , 'Sep'),
('London', '5', 'Saturday', 'Bill', 73.90 , 'Dec'),
('London', '1', 'Tuesday', 'Josie', 44.27 , 'Sep'),
('Dusseldorf', '4', 'Monday', 'Manfred', 77.00 , 'Jul'),
('Dusseldorf', '3', 'Tuesday', 'Inga', 9.99, 'Jun'),
('Dusseldorf', '4', 'Wednesday', 'Manfred', 86.81 , 'Jul'),
('London', '6', 'Friday', 'Josie', 74.02, 'Oct'),
('Dusseldorf', '1', 'Saturday', 'Manfred', 43.11, 'Apr');



-- Find all sales records (and all columns) that took place in the London store, not in December,
-- but sales concluded by Bill or Frank for the amount higher than ?50.

select *
from SALES1
where Store = 'London' 
and Month <> 'Dec'
and (SalesPerson = 'Bill' or SalesPerson = 'Frank')
and SalesAmount > 50;



-- Find out how many sales took place each week (in no particular order)

select Week, count(week)"Number of Sales"
from SALES1
group by Week;



-- Find out how many sales took place each week (and present data by week in descending and then in ascending order)

select Week, count(week)"Number of Sales"
from SALES1
group by Week
order by Week;

select Week, count(week)"Number of Sales"
from SALES1
group by Week
order by Week desc;



-- Find out how many sales were recorded each week on different days of the week

select Week, Day, count(week)"Number of Sales"
from SALES1
group by week, day
order by week, day;



-- Change salesperson's name Inga to Anette

update SALES1
set SalesPerson = 'Anette'
where SalesPerson = 'Inga';

select * from SALES1;



-- Find out how many sales did Annete do

select SalesPerson, count(salesamount)"Number of Sales"
from SALES1
where SalesPerson = 'Anette'
group by SalesPerson;



-- Find the total sales amount by each person by day

select salesperson, day, sum(salesamount)"Total Sales Amount" 
from SALES1
group by SalesPerson, day
order by SalesPerson, day;


-- How much (sum) each person sold for the given period.

select salesperson, sum(salesamount)"Total Sales Amount"
from SALES1
group by SalesPerson;



-- How much (sum) each person sold for the given period, including
-- the number of sales per person, their average, lowest and highest sale amounts.

select SalesPerson"Sales Person", sum(salesamount)"Total Sales Amount", 
count(salesamount)"Number of Sales", avg(salesamount)"Average Sales Amount", 
min(salesamount)"Lowest Sale", max(salesamount)"Highest Sale"
from SALES1
group by SalesPerson
order by "Total Sales Amount" desc;



-- Find the total monetary sales amount achieved by each store 

select Store, sum(salesamount) as 'Total Sales Amount'
from SALES1
group by Store
order by [Total Sales Amount] desc;



-- Find the number of sales by each person if they did less than 3 sales for the past period

select SalesPerson, count(salesamount) as NumberOfSales
from SALES1
group by SalesPerson
having count(salesamount) <3;



-- Find the total amount of sales by month where combined total is less than ?100

select Month, sum(salesamount)TotalSales
from SALES1
group by month
having sum(salesamount) < 100
order by [TotalSales] desc;