create database Parts;

use Parts;

create table Part
(p_id varchar(50), 
pname varchar(50), 
colour varchar(50), 
weight int, 
city varchar(50)); 

create table Project
(j_id varchar(50),
jname varchar(50),
city varchar(50));

create table Supplier
(s_id varchar(50),
sname varchar(50),
sstatus int,
city varchar(50));
 
create table Supply
(s_id varchar(50),
p_id varchar(50),
j_id varchar(50),
quantity int);

insert into Part
(p_id, pname, colour, weight, city)
values
('p1', 'nut', 'red', 12, 'london'),
('p2', 'bolt', 'green', 17, 'paris'),
('p3', 'screw', 'blue', 17, 'rome'),
('p4', 'screw', 'red', 14, 'london'),
('p5', 'cam', 'blue', 12, 'paris'),
('p6', 'cog', 'red', 19, 'london');

insert into Project
(j_id, jname, city)
values
('j1', 'sorter', 'paris'),
('j2', 'display', 'rome'),
('j3', 'ocr', 'athens'),
('j4', 'console', 'athens'),
('j5', 'raid', 'london'),
('j6', 'eds', 'oslo'),
('j7', 'tape', 'london');

insert into Supplier
(s_id, sname, sstatus, city)
values
('s1', 'smith', 20, 'london'),
('s2', 'jones', 10, 'paris'),
('s3', 'blake', 30, 'paris'),
('s4', 'clark', 20, 'london'),
('s5', 'adams', 30, 'athens');

insert into Supply
(s_id, p_id, j_id, quantity)
values
('s1', 'p1', 'j1', 200),
('s1', 'p1', 'j4', 700),
('s2', 'p3', 'j1', 400),
('s2', 'p3', 'j2', 200),
('s2', 'p3', 'j3', 200),
('s2', 'p3', 'j4', 500),
('s2', 'p3', 'j5', 600),
('s2', 'p3', 'j6', 400),
('s2', 'p3', 'j7', 800),
('s2', 'p5', 'j2', 100),
('s3', 'p3', 'j1', 200),
('s3', 'p4', 'j2', 500),
('s4', 'p6', 'j3', 300),
('s4', 'p6', 'j7', 300),
('s5', 'p2', 'j2', 200),
('s5', 'p2', 'j4', 100),
('s5', 'p5', 'j5', 500),
('s5', 'p5', 'j7', 100),
('s5', 'p6', 'j2', 200),
('s5', 'p1', 'j4', 100),
('s5', 'p3', 'j4', 200),
('s5', 'p4', 'j4', 800),
('s5', 'p5', 'j4', 400),
('s5', 'p6', 'j4', 500);



-- Find the name and status of each supplier who supplies project J2

select sname, sstatus
from Supplier 
where s_id in 
(select s_id
from Supply 
where j_id = 'J2');



-- Find the name and city of each project supplied by a London-based supplier

select jname, city
from Project
where j_id in
(select j_id
from Supply
where s_id in 
(select s_id
from Supplier
where city = 'London'));



-- Find the name and city of each project not supplied by a London-based supplier

select jname, city
from Project
where j_id not in
(select j_id 
from Supply
where s_id in
(select s_id
from Supplier
where city = 'London'));



-- Find the supplier name, part name and project name for each case where a supplier
-- supplies a project with a part, but also the supplier city, project city and
-- part city are the same

select sname, pname, jname 
from Supply sy
join Supplier s on sy.s_id = s.s_id
join Part p on sy.p_id = p.p_id
join Project pj on sy.j_id = pj.j_id
where s.city = p.city and p.city = pj.city;