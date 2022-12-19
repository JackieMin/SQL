------------------------------------------------------------------------------------------------------------------------------------
-- Домашнее задание урока 11

------------------------------------------------------------------------------------------------------------------------------------
-- 1. Вы решили начать с чего-то попроще и показали ему план запроса соединения таблиц отделов и сотрудников.

select * from departments d
join employees e on d.department_id = e.department_id;

------------------------------------------------------------------------------------------------------------------------------------
-- 2. Дальше Вы создали таблицу hr.employee_entrances “входы сотрудников” и секционировали ее по дате в диапазоне месяца.

create table hr.employee_entrances (id number generated as identity,
                                    employee_id number,
                                    enter_date date)
partition by range (enter_date)
interval (numtoyminterval (1, 'month'))
(partition p_min values less than (date'1900-01-01'))

------------------------------------------------------------------------------------------------------------------------------------
-- 3. Потом Вы заполнили эту таблицу данными.

insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-11-21');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-11-22');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-11-23');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-11-24');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-11-25');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-11-28');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-11-29');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-11-30');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-01');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-02');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-05');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-06');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-07');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-08');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-09');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-12');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-13');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-14');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-15');
insert into hr.employee_entrances (employee_id, enter_date) values (100, date '2022-12-16');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-11-21');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-11-22');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-11-23');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-11-24');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-11-25');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-11-28');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-11-29');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-11-30');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-01');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-02');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-05');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-06');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-07');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-08');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-09');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-12');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-13');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-14');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-15');
insert into hr.employee_entrances (employee_id, enter_date) values (101, date '2022-12-16');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-11-21');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-11-22');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-11-23');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-11-24');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-11-25');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-11-28');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-11-29');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-11-30');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-01');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-02');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-05');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-06');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-07');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-08');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-09');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-12');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-13');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-14');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-15');
insert into hr.employee_entrances (employee_id, enter_date) values (102, date '2022-12-16');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-11-21');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-11-22');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-11-23');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-11-24');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-11-25');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-11-28');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-11-29');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-11-30');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-01');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-02');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-05');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-06');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-07');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-08');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-09');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-12');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-13');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-14');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-15');
insert into hr.employee_entrances (employee_id, enter_date) values (103, date '2022-12-16');
commit;

------------------------------------------------------------------------------------------------------------------------------------
--4. Используя синтаксический сахар сделали подзапросы и соединили новую таблицу с выбркой из пункта 1.

with dep_emp as (select *
                 from hr.departments d
                 join hr.employees e 
                 on d.department_id = e.department_id),
     ent as (select de.employee_id,
                    de.department_name,
                    ee.enter_date
             from dep_emp de
             left join hr.employee_entrances ee
             on ee.employee_id = de.employee_id) 
select * from ent;

------------------------------------------------------------------------------------------------------------------------------------
-- 5. Начали менять подсказки оптимизатора и показывать аналитику как меняются планы запросов. Вы использовали materialize, no_merge, use_hash, parallel, use_nl.

with dep_emp as (select /*+ use_nl */ 
                        e.employee_id,
                        d.department_name
                 from hr.departments d
                 join hr.employees e 
                 on d.department_id = e.department_id),
     ent as (select de.employee_id,
                    de.department_name,
                    ee.enter_date
             from dep_emp de
             left join hr.employee_entrances ee
             on ee.employee_id = de.employee_id) 
select * from ent;

------------------------------------------------------------------------------------------------------------------------------------
-- 6. Потом Вы решили показать как меняется план вставки и применили подсказку append при вставке в таблицу сотрудников.

insert /* + append */ into hr.employees (employee_id,
                                         first_name, 
                                         last_name, 
                                         email, 
                                         phone_number, 
                                         hire_date, 
                                         job_id,
                                         salary,
                                         manager_id,
                                         department_id) values (208,
                                                                'Leonardo',
                                                                 'DiCaprio', 
                                                                 'leo@gmail.com',
                                                                 '650.123.8732',
                                                                 date '2020-02-28',
                                                                 'HR_REP',
                                                                 10000,
                                                                 101,
                                                                 40);


select * from hr.employees

with dep_emp as (select /*+ use_nl */ *
                 from hr.departments d
                 join hr.employees e 
                 on d.department_id = e.department_id),
     ent as (select de.employee_id,
                    de.department_name,
                    ee.enter_date
             from dep_emp de
             left join hr.employee_entrances ee
             on ee.employee_id = de.employee_id) 
select * from ent;


------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 11.6

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1. Напишите запрос с соединением таблиц сотрудников, отделов и типов работ.

select * from employees e
join departments d on e.department_id = d.department_id
join jobs j on j.job_id = e.job_id

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2. Напишите подсказки оптимизатору и посмотрите как они меняют план запроса. Воспользуйтесь следующими хинтами: first_rows, use_hash, use_nl, materialize.

select /*+ first_rows */ * from employees e
join departments d on e.department_id = d.department_id
join jobs j on j.job_id = e.job_id;

select /*+ use_hash*/ * from employees e
join departments d on e.department_id = d.department_id
join jobs j on j.job_id = e.job_id;

select /*+ use_nl */ * from employees e
join departments d on e.department_id = d.department_id
join jobs j on j.job_id = e.job_id;

select /*+ materialize*/ * from employees e
join departments d on e.department_id = d.department_id
join jobs j on j.job_id = e.job_id;

------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 11.5

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1. Проанализируйте план запроса.

select *

from   job_history;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2. Проанализируйте план запроса.

select *

from   job_history hst

inner join jobs j

        on j.job_id = hst.job_id;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3. Проанализируйте план запроса.

select count(1) over 

           (partition by emp.department_id 

            order by j.job_title) as cnt

from   job_history hst

inner join jobs j

        on j.job_id = hst.job_id

right outer join employees emp

              on j.job_id = emp.job_id;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 4. Проанализируйте план запроса.

select * 

from   emp_details_view;


------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 11.4

-----------------------------------------------------------------------------------------------------------------------------------
-- Задание 1. Вставьте данные о придуманной автомобильной марке в таблицу seller.maker_history с датой создания через 7 лет от текущей даты.

insert into seller.maker_history (name, start_date, end_date) values ('Stivenson', date '2029-12-18', date '2035-03-15');
commit;

select * from seller.maker_history

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2. Узнайте название секции, в которую вставились данные.

select * from all_tab_partitions 
where table_name = 'MAKER_HISTORY'

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3. Сделайте запрос к секции из задания 2.

select * from seller.maker_history partition (SYS_P1328);

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 4. Удалите данные только из секции из задания 2 через функцию truncate.

alter table seller.maker_history truncate partition SYS_P1328;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 5. Вставьте в очищенную секцию данные о (придуманной) собственной автомобильной марке.

insert into seller.maker_history partition (SYS_P1328) (name, start_date, end_date) values ('Stivenson Two', date '2029-12-05', date '2038-04-15');
commit;


------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 11.3

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1. Создайте таблицу seller.maker_history с секционированием и автоматическим созданием новых секций по дате в поле start_date (дата основания компании). 
-- Поля у этой таблицы будут:  
-- id - число, автоинкрементное поле (Идентификатор производителя), 
-- name - текст на 32 символа (Наименование производителя), 
-- start_date - дата (Дата начала работы) 
-- end_date (Дата ликвидации фирмы).

create table seller.maker_history (id number generated as identity,
                               name varchar2(32),
                               start_date date,
                               end_date date)
partition by range (start_date)
interval (numtoyminterval (1, 'month'))
(partition p_min values less than (date'1900-01-01'))



------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2. Создайте уникальный индекс seller.maker_history_pk на поле id таблицы seller.maker_history (не забудьте включить поле-ключ партиций)

create unique index seller.maker_history_pk on seller.maker_history
(id, start_date) local;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3. Вставьте данные по десяти компаниям с датами их создания и ликвидации.

insert into seller.maker_history (name, start_date, end_date) values ('ООО "Ромашка"', date '2015-01-12', date '2020-02-08');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Рога"', date '2015-02-13', date '2020-03-09');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Звездочка"', date '2015-03-14', date '2020-04-10');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Королева"', date '2015-04-15', date '2020-05-11');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Анталнт"', date '2015-05-16', date '2020-06-12');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Заводчик"', date '2015-06-17', date '2020-07-13');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Утро доброе"', date '2015-07-18', date '2020-08-14');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Самовар и Ко"', date '2015-08-19', date '2020-09-15');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Дельтаплан"', date '2015-09-20', date '2020-10-16');
insert into seller.maker_history (name, start_date, end_date) values ('ООО "Самолет"', date '2015-10-21', date '2020-11-17');
commit;

delete from seller.maker_history;
commit;

select * from seller.maker_history 
order by id


------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 11.1

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1. Создайте таблицу accountant.cards с месячным секционированием по дате в поле create_date (дата создания карты). 
-- Поля у этой таблицы будут: 
-- card_number - текст на 16 символа (Номер карты), 
-- end_month - число (Месяц окончания работы), 
-- end_year - число (Год окончания работы), 
-- employee_id - число (Ссылочный идентификатор сотрудника на поле hr.employees.employee_id).

create table accountant.cards (create_date date,
                               card_number varchar2(16),
                               end_month number,
                               end_year  number,
                               employee_id  number)
partition by range (create_date)
interval (numtoyminterval (1, 'month'))
(partition p_min values less than (date'1900-01-01'))

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2. Вставьте данные по пятнадцати сотрудникам с получением карт в разные месяцы и годы.

insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2021-10-10', 1234567890123456, 10,2024,100);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2021-11-11', 2345678901234567, 11,2024,101);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2021-12-12', 3345678901234568, 12,2024,102);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-01-01', 4234567890123459, 1,2025,103);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-02-02', 5234567890123410, 2,2025,104);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-03-03', 6234567890123411, 3,2025,105);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-04-04', 7234567890123412, 4,2025,106);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-05-05', 8234567890123413, 5,2025,107);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-06-06', 9234567890123414, 6,2025,108);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-07-07', 1023456789012315, 7,2025,109);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-08-08', 1134567890123416, 8,2025,110);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-09-09', 1234567890123417, 9,2025,111);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-10-11', 1334567890123418, 10,2025,112);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-11-12', 1434567890123419, 11,2025,113);
insert into accountant.cards (create_date, card_number, end_month, end_year, employee_id) values (date '2022-12-13', 1534567890123420, 12,2025,114);
commit;

select * from accountant.cards 

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3. Сделайте запросы к разным партициям, в том числе можете сделать соединения разных таблиц в одном запросе по полю идентификатора сотрудника.

select * from accountant.cards partition (SYS_P1252)
