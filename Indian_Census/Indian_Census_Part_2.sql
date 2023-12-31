select * from data1;
select * from data2;

-- Joining both tables

select d1.district,d1.state,d1.sex_ratio,d2.population from data1 d1
Inner Join data2 d2 on d2.district = d1.District;

-- Calculate No. of male and female
select t.district,t.state,t.population/(t.sex_ratio+1) as male, t.population*(t.sex_ratio)/(t.sex_ratio+1) as female from
(select d1.district,d1.state,d1.sex_ratio/1000,d2.population from data1 d1
Inner Join data2 d2 on d2.district = d1.District)t;


-- Total literacy Rate

select c.state.sum(literate_people), sum(illitertae people) from
(select d. district, d. state, round (d. literacy_ratio d. population, 0) literate_people,
round ((1-d.literacy ratio)* d. population, 0) as illiterate people from
(select a district, a.state, a. literacy/100 literacy ratio, b.population from project..datal a
inner join project..data2 b on a district-b.district) d) c
group by c.state;


-- Population in previous census

select sum(m.previous_census_population) previous_census_population, sum(m. current_census_population) current_census_population from(
select e.state, sum(e.previous_census_population) previous_census_population, sum(e. current_census_population) current_census_population from
(select d.district,d.state, round (d.population/(1+d.growth), 0) previous_census_population, d. population current_census_population from
(select a district, a.state, a.growth growth, b.population from project..datal a inner join project..data2 b on a.district-b.district) d) e
group by e.state)m;
