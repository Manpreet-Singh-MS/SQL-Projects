select count(*) from data1;
select count(*) from data1;

-- Dataset for jharkhand and bihar--

select * from data1 where State IN ('Jharkhand','Bihar');

-- Total Population of India

select SUM(population)as population from data2;

-- Avg Growth

select avg(growth)*100 as Avg_growth from data1;

-- Avg Growth by State
select state,avg(growth)*100 as Avg_growth from data1
group by state;

-- avg Sex Ratio

select round(avg(sex_ratio),0)as avg_sex_ratio from data1;

-- avg Sex Ratio by State

select state,round(avg(sex_ratio),0)as avg_sex_ratio from data1
group by state
order by avg_sex_ratio desc;

-- Avg Literacy Rate

select state,round(avg(literacy),0) as avg_literacy from data1
group by state
order by avg_literacy desc;

-- Avg Literacy Rate greater than 90

select state,round(avg(literacy),0) as avg_literacy from data1
group by state
having avg_literacy > 90
order by avg_literacy desc;

-- top 3 state showing highest growth ratio

select state,avg(Growth)*100 as growth_ratio from data1
group by state
order by growth_ratio desc
limit 3;

-- bottom 3 state showing lowest sex ratio

select state,round(avg(sex_ratio),0) as growth_ratio from data1
group by state
order by growth_ratio
limit 3;

-- Display Top and Bottom 3 states in literacy state

create temporary table topstates
(
state varchar(255),
topstates float
);

insert into topstates 
select state,round(avg(literacy),0) as literacy_ratio from data1
group by state
order by literacy_ratio desc
limit 3;

select * from topstates;

create temporary table bottomstates
(
state varchar(255),
bottomstates float
);

insert into bottomstates 
select state,round(avg(literacy),0) as literacy_ratio from data1
group by state
order by literacy_ratio
limit 3;

select * from bottomstates;

select * from (
select * from topstates
union
select * from bottomstates) tmp
order by state;

-- state starting from letter 'A'

select distinct(state) from data1
where state like 'A%';

-- state starting from letter 'A' or 'B'

select distinct(state) from data1
where state like 'A%' OR state like 'B%';

-- state starting from letter 'A' and ends with 'M'

select distinct(state) from data1
where state like 'A%' AND state like '%M';