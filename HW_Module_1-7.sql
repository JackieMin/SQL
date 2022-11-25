select TO_CHAR(1930-08-02, 'dd-MON-rr') as dt from dual

select to_number ('55523') as txt from dual

create table employee_cars (employee_id number,
                            car_number varchar2(16),
                            car_maker varchar2(32),
                            car_model varchar2(64))


create table duty (employee_id number,
                       duty_date date)

create table accounts (employee_id number,
                       account_num varchar2(20),
                       open_date date,
                       close_date date)

select * from accounts                       

select distinct j.job_title 
       from job_history jh 
            join employees e on jh.employee_id = e.employee_id
            full join jobs j on jh.job_id = j.job_id
       where e.last_name is null or  e.last_name <> 'Taylor'       
order by j.job_title

select * 
       from job_history jh 
            join employees e on jh.employee_id = e.employee_id
            full join jobs j on jh.job_id = j.job_id
group by j.job_title
having sum(case when e.last_name = 'Taylor' then 1 else 0 end) = 0
order by j.job_title


select * from job_history 

select * from 
            (select * from regions r  
                      join countries c on c.region_id = r.region_id 
                      left join locations l on c.country_id = l.country_id
                      right join departments d on d.location_id = l.location_id
                      full join job_history jh on jh.department_id = d.department_id
             where r.region_name = 'Europe' and jh.employee_id in ('176','200') ) t
cross join jobs 



select * from  (
                select '1m 'as id, '€нварь' as month from dual
                union all
                select '2m' as id, 'февраль' as month from dual
                union all
                select '3m' as id, 'март' as month from dual
                union all
                select '4m' as id, 'апрель' as month from dual
                union all
                select '5m' as id, 'май' as month from dual
                union all
                select '6m' as id, 'июнь' as month from dual
                union all
                select '7m' as id, 'июль' as month from dual
                union all
                select '8m' as id, 'август' as month from dual
                union all
                select '9m' as id, 'сент€брь' as month from dual
                union all
                select '10m' as id, 'окт€брь' as month from dual
                union all
                select '11m' as id, 'но€брь' as month from dual
                union all
                select '12m' as id, 'декабрь' as month from dual) months 
cross JOIN (
                select '1w 'as id, '1 недел€' as week from dual
                union all
                select '2w' as id, '2 недел€' as week from dual
                union all
                select '3w' as id, '3 недел€' as week from dual
                union all
                select '4w' as id, '4 недел€' as week from dual
                union all
                select '5w' as id, '5 недел€' as week from dual) weeks
cross JOIN (
                select '1d 'as id, 'понедельник' as day from dual
                union all
                select '2d' as id, 'вторник' as day from dual
                union all
                select '3d' as id, 'среда' as day from dual
                union all
                select '4d' as id, 'четверг' as day from dual
                union all
                select '5d' as id, 'п€тница' as day from dual
                union all
                select '6d' as id, 'суббота' as day from dual
                union all
                select '7d' as id, 'воскресенье' as day from dual) days 
order by months.id, weeks.id, days.id


select distinct job_title 
from job_history jh 
     join 
        (select * from employees e where e.last_name = 'Taylor') et 
        on jh.employee_id = et.employee_id
     full join jobs j on jh.job_id = j.job_id
where jh.employee_id is null
order by job_title

select * from jobs

select * from job_history
cross join
(select 1553 as id, 'print' as txt from dual
union all
select 1868 as id, 'type' as txt from dual) t

select * from countries
cross join jobs
cross join departments

select * from employees
cross join regions

select * from job_history jh 
full join 
(select * from jobs
where rownum < 10) j 
on jh.job_id = j.job_id
where jh.job_id is not null
order by jh.employee_id

select * from job_history jh 
right join 
(select * from jobs
where rownum < 10) j 
on jh.job_id = j.job_id
order by jh.employee_id

select * from job_history jh 
full join 
(select * from jobs
where rownum < 10) j 
on jh.job_id = j.job_id
where j.job_id is not null
order by jh.employee_id

select * from countries c 
full join locations l on c.country_id = l.country_id
where c.country_name in ('Argentina','Brazil')

select * from 
(select * from regions r
left JOIN countries c on c.region_id = r.region_id) rc
left join locations l on l.country_id = rc.country_id 
where l.country_id in ('US', 'CA', 'MX') 

select * from job_history jh
RIGHT JOIN jobs j on jh.job_id = j.job_id
where j.job_id = 'IT_PROG'

select * from countries

select * from departments d
right JOIN locations l on d.location_id = l.location_id

select * from locations

select * from 
            (select jh.employee_id,
                   e.first_name,
                   e.last_name,
                   jh.start_date,
                   jh.end_date,
                   j.job_title,
                   d.department_name
            from job_history jh
            join employees e on e.employee_id = jh.employee_id
            join jobs j on j.job_id = jh.job_id
            join departments d on d.department_id = jh.department_id
            where e.last_name = 'Whalen'
            union
            select e.employee_id,
                   e.first_name,
                   e.last_name,
                   e.hire_date,
                   date '2100-12-31',
                   j.job_title,
                   d.department_name
            from employees e
            join jobs j on j.job_id = e.job_id
            join departments d on d.department_id = e.department_id
            where e.last_name = 'Whalen') jhe
order by jhe.start_date            

select * from employees

select l.location_id,
       l.street_address,
       l.postal_code,
       l.city,
       l.state_province,
       c.country_name,
       r.region_name
from locations l
left join countries c on l.country_id = c.country_id
left join regions r on r.region_id = c.region_id

select * from countries

select * from locations

select count (*) as dep_with_manag
from 
        (select department_id,
                department_name,
                manager_id,
                location_id
        from    departments
        minus
        select department_id,
               department_name,
               manager_id,
               location_id
        from   departments
        where  manager_id is null)

select department_id,
       department_name,
       manager_id,
       location_id
from   departments
where  manager_id is not null

select *
from   departments

select * from jobs j
left join job_history jh on j.job_id = jh.job_id

select * from job_history jh
left join (select * from jobs
where rownum <10) j
on jh.job_id = j.job_id
where j.job_id is not null

select * from job_history jh
join (select * from jobs
where rownum <10) j
on jh.job_id = j.job_id

select * from job_history
select * from jobs

select * from countries c 
left join  locations l on c.country_id = l.country_id 

select * from departments d
join job_history jh on jh.department_id = d.department_id

select * from departments d
join locations l on l.location_id = d.location_id

select * from jobs j
join job_history jh on j.job_id = jh.job_id

select * from countries c 
join  locations l on c.country_id = l.country_id 

select * from locations

select region_id,
       region_name
from regions
minus
select * from 
(select 3 as region_id, 
       'Asia' as region_name 
from   dual
union all
select 2  as region_id, 
         'Americas' as region_name 
from   dual)


select department_name 
from departments
where location_id <> 1700
minus
select department_name 
from departments
where location_id = 1700



select * from departments where location_id = 1700 order by department_name 

select employee_id, 
       department_id,
       hire_date
from employees 
where employee_id = 101
union all
select employee_id, 
       department_id,
       start_date
from job_history
where employee_id = 101



select country_id,
       country_name
from countries
where region_id = 1
union all
select 'SL' as country_id, 
       '—ловени€' as country_name
from dual
union all
select 'SV' as country_id, 
       '—ловаки€' as country_name
from dual

select * from countries

select 'S1' as id, 
       'ID' as code, 
       'јйдахо' as name,
       1839106 as population
from dual
union all
select 'S2'  as id, 
       'WY' as code, 
       '¬айоминг' as name,
       576851 as population
from dual
union all
select 'S3'  as id, 
       'HI' as code, 
       '√авайи' as name,
       1455271 as population
from dual
union all
select 'S4'  as id, 
       'DE' as code, 
       'ƒелавэр' as name,
       989948 as population
from dual

select employee_id,
       ROW_NUMBER() OVER (ORDER BY employee_id asc) as rn_order,
       last_name,
       first_name,
       email,
       phone_number,
       manager_id,  
       job_id,
       salary,
       sum (salary) over (PARTITION BY manager_id ORDER BY phone_number asc) as total_manag_salary,
       commission_pct,
       lag (commission_pct, 1, 0) over (PARTITION BY manager_id ORDER BY phone_number asc) as prev_commission_pct,
       department_id,
       hire_date,
       ROW_NUMBER() OVER (PARTITION BY department_id order by hire_date asc) as hire_order
from employees 

select * from employees

select ROW_NUMBER() OVER (ORDER BY employee_id asc) as rn, t.*
from 
        (select employee_id,
                last_name,
                first_name,
                phone_number,
                manager_id,        
                salary,
                sum (salary) over (PARTITION BY manager_id ORDER BY phone_number asc) as total_manag_salary,
                commission_pct,
                lag (commission_pct, 1, 0) over (PARTITION BY manager_id ORDER BY phone_number asc) as prev_commission_pct
        from employees) t
        order by manager_id, phone_number
        
/*      
        department_id,
        hire_date,
        ROW_NUMBER() OVER (PARTITION BY department_id order by hire_date asc) as hire_order */


select  employee_id,
        ROW_NUMBER() OVER (ORDER BY employee_id asc) as rn,
        last_name,
        first_name,
        phone_number,
        manager_id,        
        salary,
        sum (salary) over (PARTITION BY manager_id ORDER BY phone_number asc) as total_manag_salary,
        commission_pct,
        lag (commission_pct, 1, 0) over (PARTITION BY manager_id ORDER BY phone_number asc) as prev_commission_pct
from employees

select  employee_id,
        ROW_NUMBER() OVER (ORDER BY employee_id asc) as rn,
        last_name,
        first_name
from employees


select * from employees

select 
       employee_id,
       department_id,
       hire_date,
       last_name,
       first_name,
       lag (last_name, 2, SYSDATE) over (partition by department_id order by hire_date, last_name) as next_last_name,
       lag (first_name, 2, SYSDATE) over (partition by department_id order by hire_date, last_name) as next_first_name
from employees
order by hire_date, last_name

select 
       employee_id,
       hire_date,
       last_name,
       first_name,
       lead (last_name) over (order by hire_date, last_name) as next_last_name,
       lead (first_name) over (order by hire_date, last_name) as next_first_name
from employees
order by hire_date, last_name

select min (department_name) as max_name
from 
        (select department_id,
                department_name,
                location_id,
                ROW_NUMBER() OVER (partition by location_id ORDER BY department_name desc) as rn
        from departments)

select * from departments order by department_name

select country_id,
       country_name,
       ROW_NUMBER() OVER (ORDER BY country_name asc) as rn        
from countries

select country_id,
       postal_code, 
       count(city) over (partition by country_id order by postal_code) as cnt_city 
from locations

select * from locations

select sum (min_salary) as min_salary
from jobs

with 
city_country as 
             (select count (city) as cnt_city,
                     country_id
              from locations
              group by country_id)
select * from city_country 
where cnt_city > 2

select * from locations

select country_id,
       state_province
from   locations
group by country_id,
       state_province

select country_id,
       state_province,
       count (*)
from   locations
group by country_id,
       state_province
having count (*) > 1  

select distinct country_id,
                state_province                
from   locations  
order by country_id,
        state_province
               

select * from locations

select first_name,
       last_name,
       phone_number,
       department_id,
       job_id
from employees
where (department_id,
      job_id) in (select department_id,
                        job_id
                 from   job_history
                 where  employee_id = 176)

select * from job_history
select * from employees

with 
    big_salary
    as 
    (select * 
     from   employees
     where  salary > 9000)
select * 
from   big_salary      
where  first_name = 'John'


select * from 
                (select * 
                 from   employees
                 where  salary > 9000)
where first_name = 'John'


select count (state_province) as cnt_state_province,
       country_id
from locations
group by country_id
having count (state_province) = 0
     

select * from locations

select sum(salary) as sum_salary, 
       department_id
from employees
group by department_id
having sum(salary) > 120000

select distinct state_province from locations

select distinct job_id from jobs

select distinct location_id from departments

select min (salary) as min_salary,
       max (salary) as max_salary,
       department_id
from employees
group by department_id

select max (min_salary) as max_min_salary,
       min (max_salary) as mix_max_salary       
from jobs

select min (country_name),
       max (country_name)
from countries

select avg (department_id) as avg_department_id,
       count (manager_id) as cnt_manager_id,
       sum (location_id) as sum_location_id,
       manager_id
from departments
group by manager_id
order by 2

select sum (salary) as sum_salary,
       manager_id
from   employees
group by manager_id
order by 1 desc


select count (manager_id) as cnt_manager_id
from Departments
where location_id = 1700

select * from Departments order by location_id, manager_id

select count (state_province) as cnt_state_province,
       country_id
from locations     
group by country_id

select count (city) as cnt_city,
       country_id
from Locations
group by country_id
     
     

select count (commission_pct) as cnt_commission_pct,
       manager_id
from   employees  
group by manager_id

select avg (commission_pct) as avg_commission_pct,
       manager_id,
       job_id
from   employees  
group by manager_id,
         job_id


select sum (salary) as sum_salary,
       department_id
from   employees  
group by department_id

select count (*) from Regions

select * from Regions

select count (manager_id) as manager_id
from departments;

select count (department_id) as department,
       location_id
from departments
group by location_id;

select * from departments order by manager_id desc

select count (job_id) as job
from jobs

select count (*) from countries;

select * from Countries; 

select avg (salary) as avg_salary,
       job_id
from employees
group by job_id
order by 1 desc

select avg (region_id) as avg_region_id
from countries

select * from countries

select avg (min_salary) as avg_MIN_SALSARY,
       avg (max_salary) as avg_MAX_SALSARY
from jobs

select * from jobs

select sum (salary) as sum_salary,
       department_id,
       manager_id
from employees
group by department_id,
        manager_id
order by sum_salary;

select sum (commission_pct) as commission_pct,
       department_id
from employees
group by department_id;

select sum (salary) as sum_salary,
       job_id
from employees
group by job_id
order by sum_salary;

select sum (salary) as sum_salary,
       job_id
from employees
group by job_id;

select * from employees order by commission_pct desc;

select sum (commission_pct) as commission_pct,
       department_id
from employees
group by department_id
order by department_id  

select sum (salary) as sum_salary,
       job_id
from employees
group by job_id
order by sum_salary;      

select job_title as d,
       job_id as r
from jobs;

select sum (salary) as sum_salary 
from employees;

select sum (min_salary) as min_salary,
       sum (max_salary) as max_salary
from jobs

select * from jobs;

select sum (location_id) as total_id
from departments;


select First_Name, 
       Last_Name, 
       Salary, 
       Hire_Date 
from Employees
where Manager_ID = 100 
order by hire_date,
         last_name,
         first_name;

/* запрос ид и названи€ департамента,
доработан - добавлено условие, что ид менеджера равно 100*/         
select department_id,   -- id департамента
       department_name  -- название департамента
from departments
where manager_id = 100;



select sum (min_salary) as total_min_salary,
       sum (max_salary) as total_max_salary      
from jobs

select * from employees where job_id = 'IT_PROG'

select sum(salary) as total_salary
from EMPLOYEES
where job_id = 'IT_PROG'
