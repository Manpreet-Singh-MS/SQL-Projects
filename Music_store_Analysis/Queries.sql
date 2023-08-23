-- Q1: Who is the senior most employee based on job title?

select first_name,last_name, title
from employee
order by levels desc
limit 1

-- Q2: Which countries have the most Invoices?

select billing_country, count(*) as Invoice_count
from invoice
group by billing_country
order by Invoice_count desc

-- Q3: What are top 3 values of total invoice?

select total 
from invoice
order by total desc

-- Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals

select billing_city,sum(total) as Invoice_Total
from invoice
group by billing_city
order by Invoice_Total Desc
limit 1;

-- Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.

select c.customer_id,c.first_name,c.last_name,sum(i.total) as total_spending
from customer c
Join invoice i on c.customer_id  = i.customer_id
group by c.customer_id
order by total_spending desc
limit 1;

