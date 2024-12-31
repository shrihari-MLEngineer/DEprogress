----Question 30

Write an SQL query to nd the npv of each query of the Queries table.
Return the result table in any order.
The query result format is in the following example.



create table if not exists NPV
(
id int,
year int,
npv int,
constraint pk PRIMARY KEY (id, year)
);

insert into NPV VALUES
(1,2018,100),(7,2020,30),(13,2019,40),(1,2019,113),(2,2008,121),(3,2009,12),(11,2020,99),(7,2019,0);

create table if not exists Queries
(
id int,
year int,
constraint pk PRIMARY KEY (id, year)
);


insert into Queries VALUES (1,2019),(2,2008),(3,2009),(7,2018),(7,2019),(7,2020),(13,2019);

---- ANSWER 
select q.id,q.year, coalesce(n.npv,0) as npv
from queries q
left join npv n on (n.id,n.year) =(q.id,q.year);





---- Question 32

--- Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
--- show null.


create table emps
(
	id int,
    name varchar(30),
    constraint pk primary key(id) 
    );


insert into emps VALUES
(1,'Alice'),(7,'Bob'),(11,'Meir'),(90,'Winston'),(3,'Jonathan');

create table if not exists EmployeeUNI
(
id int,
unique_id int,
constraint pk PRIMARY KEY (id, unique_id)
);


insert into EmployeeUNI VALUES (3,1),(11,2),(90,3);
select * from EmployeeUNI;


select e.id,e.name, coalesce(u.unique_id,0) as uni_id 
from emps e
left join EmployeeUNI u on e.id = u.id ;

--- ANSWER 
select unique_id, name
from emps
left join EmployeeUNI
on if (emps.id = EmployeeUNI.id, emps.id, null);



--- QUESTION 33

--- Write an SQL query to report the distance travelled by each user.
--- Return the result table ordered by travelled_distance in descending order, if two or more users
--- travelled the same distance, order them by their name in ascending order.

drop table users;
create table if not exists Users
(
id int,
name VARCHAR(50),
constraint pk PRIMARY KEY (id)
);

insert into Users VALUES(1,'Alice'),(2,'Bob'),(3,'Alex'),(4,'Donald'),(7,'Lee'),(13,'Jonathan'),(19,'Elvis');

create table if not exists Rides
(
id int,
user_id int,
distance int,
constraint pk PRIMARY KEY (id),
constraint fk FOREIGN KEY (user_id) REFERENCES Users(id)
);


insert into Rides VALUES
(1,1,120),(2,2,317),(3,3,222),(4,7,100),(5,13,312),(6,19,50),(7,7,120),
(8,19,400),(9,7,230);

select * from users;
select * from rides;
--- ANSWER 
select u.name, sum(ifnull(r.distance,0)) as total_distance 
from rides r
right join users u  on u.id = r.user_id 
group by u.id
order by total_distance desc , u.name ;


--- QUESTION 34

--- Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
--- and their amount.
--- Return result table in

drop table products;
create table if not exists Products
(
product_id int,
product_name varchar(50),
product_category VARCHAR(50),
constraint pk PRIMARY KEY (product_id)
);

insert into Products VALUES (1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology','Book'),(3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit','T-shirt');

drop table orders ;
create table if not exists Orders
(
product_id int,
order_date date,
unit int
);

insert into Orders values
(1,'2020-02-05',60),(1,'2020-02-10',70),(2,'2020-01-18',30),(2,'2020-02-11',80),(3,'2020-02-17',2),(3,'2020-02-24',3),(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);



select * from products;
select * from orders;

--- ANSWER
select p.product_name, sum(o.unit) as total_units 

from products p
left join orders o on o.product_id = p.product_id
where o.order_date between '2020-02-0' and '2020-02-28'
group by o.product_id 
having sum(o.unit)>100;



--- QUESTION 35

--- Write an SQL query to:
--- ● Find the name of the user who has rated the greatest number of movies. In case of a tie,
--- return the lexicographically smaller user name.
--- ● Find the movie name with the highest average rating in February 2020. In case of a tie, return
--- the lexicographically smaller movie name.


create table if not exists Movies
(
movie_id int,
title varchar(50),
constraint pk PRIMARY KEY (movie_id)
);

insert into Movies VALUES (1,'Avengers'),(2,'Frozen 2'),(3,'Joker');
select * from Movies;


create table if not exists mUsers
(
user_id int,
name varchar(50),
constraint pk PRIMARY KEY (user_id)
);


;
insert into mUsers VALUES
(1,'Daniel'),(2,'Monica'),(3,'Maria'),(4,'James');

create table if not exists MovieRating
(
movie_id int,
user_id int,
rating int,
created_at date,
constraint pk PRIMARY KEY (movie_id, user_id)
);

insert into MovieRating VALUES
(1,1,3,'2020-01-12'),(1,2,4,'2020-02-11'),(1,3,2,'2020-02-12'),(1,4,1,'2020-01-01'),(2,1,5,'2020-02-17'),(2,2,2,'2020-02-01'),(2,3,2,'2020-03-01'),(3,1,3,'2020-02-22'),(3,2,4,'2020-02-25');

select * from MovieRating;
select * from mUsers;
select * from Movies;


(select u.name 
from movierating m
left join  musers u  on m.user_id = u.user_id
group by m.user_id 
order by count(m.user_id)  desc, u.name limit 1)

union 

(select mv.title
from movierating m
join movies mv on m.movie_id = mv.movie_id
where created_at between '2020-02-01' and '2020-02-29'

group by m.movie_id 
order by sum(m.rating)/count(*) desc, mv.title limit 1);



--- QUESTION 36 

--- Write an SQL query to nd the id and the name of all students who are enrolled in departments that no longer exist.


create table if not exists Departments
(
id int,
name varchar(50),
constraint pk PRIMARY KEY (id)
);

insert into Departments VALUES (1,'ElectricalEngineering'),(7,'Computer Engineering'),(13,'Business Administration');

create table if not exists Students
(
id int,
name varchar(50),
department_id int,
constraint pk PRIMARY KEY (id)
);

insert into Students VALUES
(23,'Alice',1),(1,'Bob',7),(5,'Jennifer',13),(2,'John',14),(4,'Jasmine',77),(3,'Steve',74),(6,'Luis',1),(8,'Jonathan',7),(7,'Daiana',33),(11,'Madelynn',1);


select 
s.id , s.name 
from students s
left join departments d on s.department_id = d.id
where d.name is null ;




