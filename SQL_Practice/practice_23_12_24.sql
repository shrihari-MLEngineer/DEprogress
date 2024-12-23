
--- Question 27
Table: Users
Column Name Type
user_id int
name varchar
mail varchar
user_id is the primary key for this table.
This table contains information of the users signed up in a website. Some emails are invalid.
Write an SQL query to nd the users who have valid emails.
A valid e-mail has a prex name and a domain where:
● The prex name is a string that may contain letters (upper or lower case), digits, underscore
'_', period '.', and/or dash '-'. The prex name must start with a letter.
● The domain is '@leetcode.com'.
Return the result table in any order.
The query result format is in the following example

Input:
Users table:
user_id name mail
1 Winston
winston@leetc
ode.com
2 Jonathan jonathanisgreat
3 Annabelle
bella-@leetcod
e.com
4 Sally
sally.come@lee
tcode.com
5 Marwan
quarz#2020@le
etcode.com
6 David
david69@gmail
.com
7 Shapiro
.shapo@leetco
de.com

user_id name mail
1 Winston
winston@leetc
ode.com
3 Annabelle
bella-@leetcod
e.com
4 Sally
sally.come@lee
tcode.com

--- ANSWER 

create table if not exists Users
(
user_id int,
name varchar(50),
mail varchar(50),
constraint pk PRIMARY KEY (user_id)
);

insert into Users VALUES
(1,'Winston','winston@leetcode.com'),(2,'Jonathan','jonathanisgreat'),(3,'Annabelle','bella-@leetcode.com'),(4,'Sally','sally.come@leetcode.com'),(5,'Marwan','quarz#2020@leetcode.com'),(6,'David','david69@gmail.com'),(7,'Shapiro','.shapo@leetcode.com');

select * from Users ;

select * 
from Users 
where mail regexp '^[A-Za-z][A-Za-z0-9\-\_\.]*@leetcode.com';




--- Question 28 

Write an SQL query to report the customer_id and customer_name of customers who have spent at
least $100 in each month of June and July 2020.
Return the result table in any order.
The query result format is in the following example.

create table if not exists Customers
(
customer_id int,
name varchar(50),
country varchar(50),
constraint pk PRIMARY KEY (customer_id)
);

insert into Customers VALUES
(1,'Winston','USA'),(2,'Jonathan','Peru'),(3,'Moustafa','Egypt');

create table if not exists Product
(
product_id int,
description varchar(255),
price int,
constraint pk PRIMARY KEY (product_id)
);

insert into Product values (10,'LC Phone',300),(20,'LC
T-Shirt',10),(30,'LC Book',45),(40,'LC Keychain',2);

create table if not exists Orders
(
order_id int,
customer_id int,
product_id int,
order_date DATE,
quantity int,
constraint pk PRIMARY KEY (order_id)
-- constraint fk FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
-- constraint fk FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

drop table Orders;

show create table orders ;

insert into Orders VALUES
(1,1,10,'2020-06-10',1),(2,1,20,'2020-07-01',1),(3,1,30,'2020-07-08',2),(4,2,10,'2020-06-15',2),(5,2,40,'2020-07-01',10),(6,3,20,'2020-06-24',2),(7,3,30,'2020-06-25',2),(9,3,30,'2020-05-08',3);


select * from orders;
select * from product;
select * from customers;

select 
c.customer_id, c.name 
from customers c
join orders o on c.customer_id = o.customer_id
join product p on p.product_id = o.product_id 
group by c.customer_id 
having 
(
sum(case when o.order_date like '2020-06-%' then o.quantity * p.price else 0 end) > 100 
and 
sum(case when o.order_date like '2020-07-%' then o.quantity * p.price else 0 end )> 100 );

select 
o.customer_id , c.name 
from orders o  
join product p on o.product_id=p.product_id 
join customers c on o.customer_id = c.customer_id
group by c.customer_id,c.name 
having 
(
sum(case when o.order_date between '2020-06-01' and '2020-06-30' then o.quantity * p.price else 0 end ) >= 100 
and 
sum(case when o.order_date between '2020-07-01' and '2020-07-30' then o.quantity * p.price else 0 end ) >= 100 )
;



--- QUESTION 29 

Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
Return the result table in any order.
The query result format is in the following example.


create table if not exists TVProgram
(
program_date date,
content_id int,
channel varchar(50),
constraint pk PRIMARY KEY (program_date, content_id)
);

insert into TVProgram VALUES ('2020-06-10 08:00',1,'LC-Channel'),('2020-05-11 12:00',2,'LC-Channel'),('2020-05-12 12:00',3,'LC-Channel'),('2020-05-13 14:00',4,'Disney Ch'),('2020-06-18 14:00',4,'Disney Ch'),('2020-07-15 16:00',5,'Disney Ch');


create table if not exists Content
(
content_id varchar(50),
title varchar(50),
Kids_content enum('Y','N'),
content_type varchar(50),
constraint pk PRIMARY KEY (content_id)
);

insert into Content VALUES (1,'Leetcode Movie','N','Movies'),(2,'Alg.for Kids','Y','Series'),(3,'DatabaseSols','N','Series'),(4,'Aladdin','Y','Movies'),(5,'Cinderella','Y','Movies');

select * from content ;
select * from tvprogram ;

select distinct c.title
from content c
join tvprogram t on c.content_id = t.content_id 
where t.program_date between '2020-06-01' and '2020-06-30' and c.kids_content = 'Y' and c.content_type = 'Movies' ;






