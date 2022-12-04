------------------------------------------------------------------------------------------------------------------------------------
-- Домашнее задание урока 10

------------------------------------------------------------------------------------------------------------------------------------
-- 1 Создайте схему ods (operational data store).

create user ods 
       identified by ods1
       default tablespace sysaux
       temporary tablespace temp 
       account unlock;

alter user ods quota unlimited on sysaux;

grant create session to ods

------------------------------------------------------------------------------------------------------------------------------------
-- 2 и 3 Создайте в схеме ods таблицы в третьей нормальной форме со всеми связями и индексами. Вам необходимо создать следующие таблицы:

create table ods.customers (cust_id number generated as identity,
                            first_name varchar2(32),
                            last_name varchar2(32),
                            phone varchar(32),
                            birth_date date);

create unique index cust_pk on ods.customers(cust_id);

alter table ods.customers add CONSTRAINT cust_pk PRIMARY KEY (cust_id);

---                        

create table ods.accounts (acc_id number generated as identity,
                           cust_id int,
                           acc_num int,
                           open_date date,
                           close_date date,
                           foreign key (cust_id) references ods.customers (cust_id));

create unique index acc_pk on ods.accounts(acc_id);

alter table ods.accounts add CONSTRAINT acc_pk PRIMARY KEY (acc_id);    

alter table ods.accounts 
MODIFY cust_id NOT NULL;

---

create table ods.cards (card_id number generated as identity,
                        acc_id int,
                        card_num int,
                        end_month int,
                        end_year int,
                        foreign key (acc_id) references ods.accounts (acc_id));

create unique index card_pk on ods.cards(card_id);

alter table ods.cards add CONSTRAINT card_pk PRIMARY KEY (card_id);     

alter table ods.cards 
MODIFY acc_id NOT NULL;

---

create table ods.operations (cust_id int not null,
                             card_id int not null,
                             opp_sum int,
                             opp_date int,
                             foreign key (cust_id) references ods.customers (cust_id),
                             foreign key (card_id) references ods.cards (card_id));

alter table ods.operations 
MODIFY opp_date date;

------------------------------------------------------------------------------------------------------------------------------------
-- 4 Заполнить несколько строк для тестирования.

insert into ods.customers ( first_name,
                            last_name,
                            phone,
                            birth_date)
values ('Minakova',
        'Evgeniya',
        '+7(913)924-1413',
        to_date ('28.02.1982', 'dd.mm.yyyy'));


insert into ods.customers ( first_name,
                            last_name,
                            phone,
                            birth_date)
values ('Senko',
        'Alexandr',
        '+7(913)909-2381',
        to_date ('11.05.1985', 'dd.mm.yyyy'))

commit


insert into ods.accounts (cust_id,
                          acc_num,
                          open_date)
values (1,
        1234567891023456,
        to_date ('01.12.2022', 'dd.mm.yyyy'));
insert into ods.accounts (cust_id,
                          acc_num,
                          open_date)
values (2,
        6543210987654321,
        to_date ('15.11.2022', 'dd.mm.yyyy'));
        
commit;        


insert into ods.cards (acc_id,
                       card_num,
                       end_month,
                       end_year)
values (1,
        1111222233334444,
        12,
        2022);
insert into ods.cards (acc_id,
                       card_num,
                       end_month,
                       end_year)
values (2,
        555566667777888,
        11,
        2022);
commit

update ods.cards 
set end_year = 2025;



insert into ods.operations (cust_id,
                             card_id,
                             opp_sum,
                             opp_date)
values (1,
        1,
        10000,
        to_date ('02.12.2022', 'dd.mm.yyyy'));
insert into ods.operations (cust_id,
                             card_id,
                             opp_sum,
                             opp_date)
values (1,
        1,
        15000,
        to_date ('03.12.2022', 'dd.mm.yyyy'));
insert into ods.operations (cust_id,
                             card_id,
                             opp_sum,
                             opp_date)
values (2,
        2,
        55000,
        to_date ('16.11.2022', 'dd.mm.yyyy'));
insert into ods.operations (cust_id,
                             card_id,
                             opp_sum,
                             opp_date)
values (2,
        2,
        48000,
        to_date ('23.11.2022', 'dd.mm.yyyy'));   
commit        


select cm.first_name "Фамилия",
       cm.last_name "Имя",
       cm.phone "Телефон",
       cm.birth_date "Дата рождения",
       o.opp_sum "Сумма операции",
       o.opp_date "Дата операции",
       c.card_num "Номер карты",
       a.acc_num "Номер счета"
from ods.operations o
join ods.cards c on c.card_id = o.card_id
join ods.accounts a on a.acc_id = c.acc_id
join ods.customers cm on cm.cust_id = a.cust_id;

