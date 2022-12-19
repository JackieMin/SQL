
------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 10.4


------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 ������� ������� seller.model_tmp ����� create as select ������� seller.model.

create table seller.model_tmp (id number generated as identity,
                            name varchar2(32) not null,
                            maker_id,
                            foreign key (maker_id) references seller.maker (id));   

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 ��������� ������� seller.model_tmp ���������� ����������� �������� ������������� � ID. ��� ����� ��������� SQL ������ script_of_models.sql. ��� �� ������� � ����� Gitlab



------------------------------------------------------------------------------------------------------------------------------------
-- ������� 3 �������� � ������� seller.models ����� insert as select ������ �� ������� seller.models_tmp.

insert into seller.model ( name,
                          maker_id)
select  name,
        maker_id
from seller.model_tmp;

select * from seller.model

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 4 ������������ ����������.

commit

------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 10.3


------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� (update) ������� seller,maker �� ������� ������������ ������������� - ���, �������� �� Lada.

update seller.maker 
set    name = 'Lada'
where  name = '���'


------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 ��������� (count) ���������� ����� �� ���� ������� seller,maker.

select count (id) from seller.maker


------------------------------------------------------------------------------------------------------------------------------------
-- ������� 3 ������� (delete) �� ������� seller,maker ������ �� ������� ������������ ������������� - Lada

delete from seller.maker 
where  name = 'Lada'


------------------------------------------------------------------------------------------------------------------------------------
-- ������� 4 ��������� (count) ���������� ����� �� ���� ������� seller,maker.

select count (id) from seller.maker

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 5 �������� � ������� seller.maker ������������� ���.

insert into seller.maker (name) values ('���');

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 6 ������������� ����������.

commit


------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 10.2

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 ��������� ������� seller.maker �� ������ �������������� ����������� �� ���.

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
insert into seller.maker (name) values ('���');
insert into seller.maker (name) values ('���');
insert into seller.maker (name) values ('���');


------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 ������������ ����������.

commit

------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 10.1

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ����� seller.

create user seller 
       identified by seller
       default tablespace sysaux
       temporary tablespace temp 
       account unlock;

alter user seller quota unlimited on sysaux;

grant create session to seller;


------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ������� seller.maker (������������� �����������) ������: id - �����, ���������������� ���� (������������� �������������), name - ����� �� 32 ������� (������������ �������������).

create table seller.maker (id number generated as identity,
                            name varchar2(32))                            

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 3 �������� ���������� ������ maker_pk �� ���� id ������� maker.

create unique index maker_pk on seller.maker(id)

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 4 �������� ����������� primary key maker_pk �� ���� id ������� maker.

alter table seller.maker add CONSTRAINT maker_pk PRIMARY KEY (id)

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 5 �������� ������� seller.model (������ �����������) ������: id - �����, ���������������� ���� (������������� ������), name - ����� �� 32 ������� (������������ �������������), 
-- maker_id - ����� (������������� ������������� �����������). �������� ����������� foreign key ���� maker_id �� ���� id ������� maker.

create table seller.model (id number generated as identity,
                            name varchar2(32) not null,
                            maker_id,
                            foreign key (maker_id) references seller.maker (id))   

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 6 �������� ���������� ������ model_pk �� ���� id ������� model.

create unique index model_pk on seller.model(id)