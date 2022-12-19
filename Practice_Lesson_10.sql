
------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 10.4


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создать таблицу seller.model_tmp через create as select таблицы seller.model.

create table seller.model_tmp (id number generated as identity,
                            name varchar2(32) not null,
                            maker_id,
                            foreign key (maker_id) references seller.maker (id));   

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Заполнить таблицу seller.model_tmp преобразуя натуральное значение производителя в ID. Для этого выполните SQL скрипт script_of_models.sql. Его вы найдете в папке Gitlab



------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Вставьте в таблицу seller.models через insert as select данные из таблицы seller.models_tmp.

insert into seller.model ( name,
                          maker_id)
select  name,
        maker_id
from seller.model_tmp;

select * from seller.model

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 4 Зафиксируйте транзакцию.

commit

------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 10.3


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Обновить (update) таблицу seller,maker по условию наименования производителя - ВАЗ, обновить на Lada.

update seller.maker 
set    name = 'Lada'
where  name = 'ВАЗ'


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Посчитать (count) количество строк во всей таблице seller,maker.

select count (id) from seller.maker


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Удалить (delete) из таблицы seller,maker строки по условию наименования производителя - Lada

delete from seller.maker 
where  name = 'Lada'


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 4 Посчитать (count) количество строк во всей таблице seller,maker.

select count (id) from seller.maker

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 5 Вставить в таблицу seller.maker производителя ВАЗ.

insert into seller.maker (name) values ('ВАЗ');

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 6 Зафиксировать транзакцию.

commit


------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 10.2

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Заполните таблицу seller.maker по списку производителей автомобилей из гит.

insert into seller.maker (name) values ('Acura');
insert into seller.maker (name) values ('Alfa Romeo');
insert into seller.maker (name) values ('Aston Martin');
insert into seller.maker (name) values ('Audi');
insert into seller.maker (name) values ('Bentley');
insert into seller.maker (name) values ('BMW');
insert into seller.maker (name) values ('Buick');
insert into seller.maker (name) values ('Cadillac');
insert into seller.maker (name) values ('Chery');
insert into seller.maker (name) values ('Chevrolet');
insert into seller.maker (name) values ('Chrysler');
insert into seller.maker (name) values ('Citroen');
insert into seller.maker (name) values ('Daewoo');
insert into seller.maker (name) values ('Daihatsu');
insert into seller.maker (name) values ('Dodge');
insert into seller.maker (name) values ('FAW');
insert into seller.maker (name) values ('Ferrari');
insert into seller.maker (name) values ('Fiat');
insert into seller.maker (name) values ('Ford');
insert into seller.maker (name) values ('Geely');
insert into seller.maker (name) values ('GMC');
insert into seller.maker (name) values ('Great Wall');
insert into seller.maker (name) values ('Honda');
insert into seller.maker (name) values ('Hummer');
insert into seller.maker (name) values ('Hyundai');
insert into seller.maker (name) values ('Infiniti');
insert into seller.maker (name) values ('Isuzu');
insert into seller.maker (name) values ('Jaguar');
insert into seller.maker (name) values ('Jeep');
insert into seller.maker (name) values ('Kia');
insert into seller.maker (name) values ('Lamborghini');
insert into seller.maker (name) values ('Lancia');
insert into seller.maker (name) values ('Land Rover');
insert into seller.maker (name) values ('Lexus');
insert into seller.maker (name) values ('Lifan');
insert into seller.maker (name) values ('Lincoln');
insert into seller.maker (name) values ('Lotus');
insert into seller.maker (name) values ('Marussia');
insert into seller.maker (name) values ('Maserati');
insert into seller.maker (name) values ('Maybach');
insert into seller.maker (name) values ('Mazda');
insert into seller.maker (name) values ('McLaren');
insert into seller.maker (name) values ('Mercedes');
insert into seller.maker (name) values ('Mercury');
insert into seller.maker (name) values ('MG');
insert into seller.maker (name) values ('Mini');
insert into seller.maker (name) values ('Mitsubishi');
insert into seller.maker (name) values ('Nissan');
insert into seller.maker (name) values ('Opel');
insert into seller.maker (name) values ('Peugeot');
insert into seller.maker (name) values ('Pontiac');
insert into seller.maker (name) values ('Porsche');
insert into seller.maker (name) values ('Renault');
insert into seller.maker (name) values ('Rolls-Royce');
insert into seller.maker (name) values ('Rover');
insert into seller.maker (name) values ('Saab');
insert into seller.maker (name) values ('Saturn');
insert into seller.maker (name) values ('Scion');
insert into seller.maker (name) values ('Seat');
insert into seller.maker (name) values ('Skoda');
insert into seller.maker (name) values ('Smart');
insert into seller.maker (name) values ('Ssang Yong');
insert into seller.maker (name) values ('Subaru');
insert into seller.maker (name) values ('Suzuki');
insert into seller.maker (name) values ('Tesla');
insert into seller.maker (name) values ('Toyota');
insert into seller.maker (name) values ('Volkswagen');
insert into seller.maker (name) values ('Volvo');
insert into seller.maker (name) values ('ВАЗ');
insert into seller.maker (name) values ('ГАЗ');
insert into seller.maker (name) values ('УАЗ');


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Зафиксируйте транзакцию.

commit

------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 10.1

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создайте схему seller.

create user seller 
       identified by seller
       default tablespace sysaux
       temporary tablespace temp 
       account unlock;

alter user seller quota unlimited on sysaux;

grant create session to seller;


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Создайте таблицу seller.maker (Производитель автомобилей) полями: id - число, автоинкрементное поле (Идентификатор производителя), name - текст на 32 символа (Наименование производителя).

create table seller.maker (id number generated as identity,
                            name varchar2(32))                            

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Создайте уникальный индекс maker_pk на поле id таблицы maker.

create unique index maker_pk on seller.maker(id)

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 4 Создайте ограничение primary key maker_pk на поле id таблицы maker.

alter table seller.maker add CONSTRAINT maker_pk PRIMARY KEY (id)

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 5 Создайте таблицу seller.model (Модели автомобилей) полями: id - число, автоинкрементное поле (Идентификатор модели), name - текст на 32 символа (Наименование производителя), 
-- maker_id - число (Идентификатор производителя автомобилей). Создайте ограничение foreign key поля maker_id на поле id таблицы maker.

create table seller.model (id number generated as identity,
                            name varchar2(32) not null,
                            maker_id,
                            foreign key (maker_id) references seller.maker (id))   

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 6 Создайте уникальный индекс model_pk на поле id таблицы model.

create unique index model_pk on seller.model(id)