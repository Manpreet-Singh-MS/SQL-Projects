show databases;

use org;

CREATE TABLE Worker 
(
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT,
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

show tables;

desc worker;

insert into worker values
(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
        
select * from worker;

create table bonus
(
	worker_ref_id int,
	bonus_amount int,
	bonus_date DATETIME,
	foreign key (worker_ref_id) references worker(worker_id)
	on delete cascade

);

insert into bonus values
(001, 5000, '16-02-20'),
(002, 3000, '16-06-11'),
(003, 4000, '16-02-20'),
(001, 4500, '16-02-20'),
(002, 3500, '16-06-11');
        
select * from bonus;

create table title
(
	worker_ref_id int,
	worker_title varchar(25),
	affected_from DATETIME,
	foreign key(worker_ref_id) references worker(worker_id)
	ON DELETE cascade
    
);

insert into title values
(001, 'Manager', '2016-02-20 00:00:00'),
(002, 'Executive', '2016-06-11 00:00:00'),
(008, 'Executive', '2016-06-11 00:00:00'),
(005, 'Manager', '2016-06-11 00:00:00'),
(004, 'Asst. Manager', '2016-06-11 00:00:00'),
(007, 'Executive', '2016-06-11 00:00:00'),
(006, 'Lead', '2016-06-11 00:00:00'),
(003, 'Lead', '2016-06-11 00:00:00');
 
 select * from worker;
 select * from bonus;
 select * from title;
 
--  Q-1. Write an SQL query to fetch “FIRST_NAME” from the Worker table using the alias name <WORKER_NAME>.-- 

select first_name as Worker_Name from worker;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from the Worker table in upper case.

select upper(First_name) from worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.

select distinct(department) from worker;

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from the Worker table.

select substring(first_name,1,3) from worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from the Worker table.

select instr(First_name,BINARY 'a') from worker 
where first_name = "Amitabh";

-- Q-6. Write an SQL query to print the FIRST_NAME from the Worker table after removing white spaces from the right side.

select rtrim(first_name) from worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from the Worker table after removing white spaces from the left side.

select ltrim(first_name) from worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from the Worker table and prints its length.

select distinct length(department) from worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from the Worker table after replacing ‘a’ with ‘A’.

select replace(First_name,'a','A') from worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from the Worker table into a single column COMPLETE_NAME. A space char should separate them.

select concat(first_name,' ',last_name) as full_name from worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.

select * from worker
order by first_name asc;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.

select * from worker
order by first_name asc ,department desc;

-- Q-13. Write an SQL query to print details for Workers with the first names “Vipul” and “Satish” from the Worker table.

select * from worker
where first_name IN ('Vipul','Satish');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from the Worker table.

select * from worker
where first_name NOT IN ('Vipul','Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.

select * from worker
where department = 'Admin';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.

select first_name from worker
where first_name like '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.

select first_name from worker
where first_name like '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.

select * from worker
where first_name like '%_____h';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.

select * from worker
having salary between 100000 and 500000;

-- Q-20. Write an SQL query to print details of the Workers who joined in Feb’2014.

select * from worker
where year(joining_date) = 2014 and month(joining_date) = 2;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.

select count(*) from worker
where department = 'Admin';

-- Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.

select concat(First_name,' ',last_name) as full_name,salary from worker
where worker_id IN (select worker_id from worker where salary between 50000 and 100000);

-- Q-23. Write an SQL query to fetch the no. of workers for each department in descending order

select department,count(worker_id) as Total_Count from worker
group by department
order by Total_Count Desc;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.

select w.*,t.worker_title from worker w
inner join title t on t.worker_ref_id = w.worker_id
where t.worker_title = 'Manager';

-- Q-25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.

select worker_title,affected_from, count(*) from title
group by worker_title,affected_from
having count(*) > 1;

-- Q-26. Write an SQL query to show only odd rows from a table.

select * from worker
where mod(worker_id,2) <> 0;

-- Q-27. Write an SQL query to show only even rows from a table.

select * from worker
where mod(worker_id,2) = 0;

-- Q-28. Write an SQL query to clone a new table from another table.

create table workerclone like worker;

insert into workerclone 
select * from worker;

select * from workerclone;

-- Q-29. Write an SQL query to fetch intersecting records of two tables.

(select * from worker)
INTERSECT
(select * from workerclone)

-- Q-30. Write an SQL query to show records from one table that another table does not have.

(select * from worker)
MINUS
(select * from title)

-- Q-31. Write an SQL query to show the current date and time.

select curDate();

-- Q-32. Write an SQL query to show the top n (say 10) records of a table.

select * from worker
order by salary desc
limit 10;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.

select salary as nth_salary from worker
order by salary desc
limit n-1,1;

-- Q-34. Write an SQL query to determine the 5th highest salary without using the TOP or limit method.

select salary as 5th_Highest_salary from worker w1
where 4 = (select count(distinct(w2.salary))
from worker w2
where w2.salary >= w1.salary
);

-- Q-35. Write an SQL query to fetch the list of employees with the same salary.

select distinct w.worker_id,w.first_name,w.last_name,w.salary from
worker w, worker w1
where w.salary = w1.salary and w.worker_id != w1.worker_id;

-- Q-36. Write an SQL query to show the second-highest salary from a table.

select max(salary) from worker
where salary Not in (select Max(salary) from worker);

-- Q-37. Write an SQL query to show one row twice in the results from a table.

select first_name, department from worker w
where department = 'HR'
union all
select first_name, department from worker w1
where department = 'HR';

-- Q-38. Write an SQL query to fetch intersecting records of two tables.

select * from worker w
INTERSECT
select * from worker w1;

-- Q-39. Write an SQL query to fetch the first 50% of records from a table.

select * from worker
where worker_id <= (select count(worker_id)/2 from worker);

-- Q-40. Write an SQL query to fetch the departments that have less than five people in them.

select department,count(worker_id) as no_of_workers from worker
group by department
having count(worker_id) < 5;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.

select department,count(department) as no_of_workers from worker
group by department;

-- Q-42. Write an SQL query to show the last record from a table.

select * from worker
where worker_id = (select max(worker_id) from worker);

-- Q-43. Write an SQL query to fetch the first row of a table.

select * from worker
where worker_id = (select min(worker_id) from worker);

#Limit function also can be used for the desired result

-- Q-44. Write an SQL query to fetch the last five records from a table.

select * from worker
order by worker_id desc
limit 5;