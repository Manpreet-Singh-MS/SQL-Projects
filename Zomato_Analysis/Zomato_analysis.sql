use zomato;

CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'2017-09-22'),
(3,'2017-04-21');

CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');


CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES 
(1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);


CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);

select * from goldusers_signup;
select * from product;
select * from sales;
select * from users;

-- what is the total amount spend by each customer on zomato

select s.userid,sum(p.price) as Total_Amount from sales s
Join product p on p.product_id  = s.product_id
group by s.userid
order by Total_amount Desc;

-- How many days has each customer visited zomato

select userid, count(distinct(created_date)) as user_visited from sales
group by userid
order by user_visited desc;

-- What was the first product purchased by user

select userid, created_date,product_id from (select *,rank() over(partition by userid order by created_date) as rnk from sales)tmp
where rnk = 1;

-- What is the most purchased item on the menu and how many times was it purchased by all customers?

select * from sales;

select * from sales where product_id = (select product_id,count(product_id) as count_sales from sales group by product_id order by count_sales desc limit 1);


-- Which item is most popular for each customer

select * from 
(select *, rank() over(partition by userid order by sales_count desc) as rnk from 
(select userid,product_id,count(product_id) as sales_count from sales
group by userid,product_id)a)b
where rnk = 1;

-- Which item was purchased first by the customer after they become  a member

select * from goldusers_signup;
select * from sales;
select * from product;

select * from 
(select a.*,rank()over(partition by userid order by created_date asc) as rnk from
(select g.userid,g.gold_signup_date,s.created_date,s.product_id from goldusers_signup g
Inner Join sales s on s.userid = g.userid
where g.gold_signup_date <= s.created_date)a)b
where rnk = 1;

-- Which item was purchased first by the customer before they become  a member

select * from 
(select a.*,rank()over(partition by userid order by created_date desc) as rnk from
(select g.userid,g.gold_signup_date,s.created_date,s.product_id from goldusers_signup g
Inner Join sales s on s.userid = g.userid
where g.gold_signup_date >= s.created_date)a)b
where rnk = 1;

-- What is the total orders and amount spent for each member before they become a member

select userid,count(created_date) as order_count, sum(price) as Total_spent from
(select g.userid,g.gold_signup_date,s.created_date,s.product_id,p.price from goldusers_signup g
Inner Join sales s on s.userid = g.userid
Inner Join product p on p.product_id = s.product_id
where g.gold_signup_date >= s.created_date)a
group by userid;