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


