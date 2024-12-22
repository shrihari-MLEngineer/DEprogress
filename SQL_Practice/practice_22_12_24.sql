--- Question 24
Table: Activity
Column Name Type
player_id int
device_id int
event_date date
games_played int
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before
logging out on someday using some device.
Write an SQL query to report the rst login date for each player.
Return the result table in any order.
The query result format is in the following example.
Input:
Activity table:
player_id device_id event_date games_played
1 2 2016-03-01 5
1 2 2016-05-02 6
2 3 2017-06-25 1
3 1 2016-03-02 0
3 4 2018-07-03 5


Output:
player_id rst_login
1 2016-03-01
2 2017-06-25
3 2016-03-02



create database practice;
use practice ;

---------------- table creation and values of the tables have been copied from the answer file.
create table if not exists Activity
(
player_id int,
device_id int,
event_date date,
games_played INT DEFAULT 0,
constraint pk PRIMARY KEY (player_id, event_date)
);

INSERT into Activity values
(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);


--- Answer
select 
player_id,
min(event_date)
from activity 
group by player_id 
order by player_id;


--- Using ROw_NUmber()

select
tmp.player_id , tmp.event_date
from (select *,
		row_number() over(partition by player_id) as row_num
        from activity ) tmp
where row_num = 1;






---        QUESTION 25

Table: Activity
Column Name Type
player_id int
device_id int
event_date date
games_played int
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before
logging out on someday using some device.
Write an SQL query to report the device that is rst logged in for each player.
Return the result table in any order.
The query result format is in the following example.
Input:
Activity table:
player_id device_id event_date games_played
1 2 2016-03-01 5
1 2 2016-05-02 6
2 3 2017-06-25 1
3 1 2016-03-02 0
3 4 2018-07-03 5
Output:
player_id device_id
1 2
2 3
3 1


--- ANSWERS 

select 
s.player_id,
s.device_id 
from ( select * from activity a
group by a.player_id
having a.event_date = min(a.event_date)) s;

-- The above solution is wrong ... I was not able to handle this without the row_number() need to understand to solve such kind of questions with multiple approches.

--- USING ROW_NUMBER()

select 
tmp.player_id , tmp.device_id 
from (select *,
       row_number() over(partition by player_id order by event_date) as row_num
       from activity 
       ) as tmp
where row_num = 1





--- QUESTIN 26
Table: Products
Column Name Type
product_id int
product_name varchar
product_category varchar
product_id is the primary key for this table.
This table contains data about the company's products.
Table: Orders
Column Name Type
product_id int
order_date date
unit int
There is no primary key for this table. It may have duplicate rows.
product_id is a foreign key to the Products table.
unit is the number of products ordered in order_date.
Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.
Return result table in any order.
The query result format is in the following example.
Input:
Products table:
product_id product_name
product_catego
ry
1
Leetcode
Solutions Book
2
Jewels of
Stringology Book
3 HP Laptop
4 Lenovo Laptop
5 Leetcode Kit T-shirt
Orders table:
product_id order_date unit
1 2020-02-05 60
1 2020-02-10 70
2 2020-01-18 30
2 2020-02-11 80
3 2020-02-17 2
3 2020-02-24 3
4 2020-03-01 20
4 2020-03-04 30
4 2020-03-04 60
5 2020-02-25 50
5 2020-02-27 50
5 2020-03-01 50
Output:
product_name unit
Leetcode Solutions 130
Leetcode Kit 100'




create table if not exists Products
(
product_id int,
product_name VARCHAR(50),
product_category VARCHAR(50),
constraint pk PRIMARY KEY (product_id)
);

insert into Products values (1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology','Book'),
(3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit','T-shirt');

create table if not exists Orders
(
product_id int,
order_date date,
unit int,
constraint fk FOREIGN KEY (product_id) REFERENCES
Products(product_id)
);

insert into Orders values
(1,'2020-02-05',60),(1,'2020-02-10',70),(2,'2020-01-18',30),(2,'2020-02-11',80),(3,'2020-02-17',2),(3,'2020-02-24',3),(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);



select * from orders ;
select * from products ;


--- ANSWER 
select 
p.product_name , sum(o.unit) as number_of_units 
from products p 
join orders o on p.product_id = o.product_id
where  o.order_date between '2020-02-' and '2020-02-29'
group by o.product_id 
having sum(o.unit) >100 ;


