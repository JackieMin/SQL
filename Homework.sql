-- �������� ����� ������� �� ������� �� ������� ����������� � ������������ ���������� �������� � ������ � �������� ������.

select d.department_name,
       to_char(sum(e.salary),'$999G999')
from   employees e
join   departments d on 
       d.department_id = e.department_id
group by d.department_name
order by 2 desc

------------------------------------------------------------------------------------------------------------------------------------
-- ������������ ���� ����� ����������� �� ������� ����������� �� ������� ������ ���� �����.

SELECT employee_id,
       last_name,
       first_name,
       hire_date,
       trunc (hire_date, 'yyyy') as first_year_date
FROM employees 
order by 1

------------------------------------------------------------------------------------------------------------------------------------
-- ��������� �������� ������������ ���������� �������� � ������� 2 � ����� �� ��������� ����.

SELECT employee_id,
       last_name,
       first_name,
       hire_date,
       to_char (trunc (hire_date, 'yyyy'), 'yyyy') as year_txt
FROM employees 
order by 1

------------------------------------------------------------------------------------------------------------------------------------
-- ��������� �������� ������������ ���������� �������� � ������� 2 � ����� �� ��������� ����.

SELECT employee_id,
       last_name,
       first_name,
       hire_date,
       to_number(to_char (trunc (hire_date, 'yyyy'), 'yyyy')) as year_num
FROM employees 
order by 1

------------------------------------------------------------------------------------------------------------------------------------
-- ��������� �����������, ������������ � ������� ���� ����� �� ������ ������� 2.

SELECT max (to_number(to_char (trunc (hire_date, 'yyyy'), 'yyyy'))) as max_year,
       min (to_number(to_char (trunc (hire_date, 'yyyy'), 'yyyy'))) as min_year,
       avg (to_number(to_char (trunc (hire_date, 'yyyy'), 'yyyy'))) as avg_year
FROM employees 

------------------------------------------------------------------------------------------------------------------------------------
-- �������� ������� hurricane (���������� ��������) � ������: name - ����� �� 64 ������� (������������), report_year - ���� (���, � ������� �������� ������), victims - ����� (���������� �����).

create table hurricane (name varchar2(64),
                        report_year date,
                        victims number)
                        
------------------------------------------------------------------------------------------------------------------------------------
-- �������� �� ���� ������������ ������� ����������� ������������� ����� null.

alter table hurricane modify name not null

------------------------------------------------------------------------------------------------------------------------------------
-- �������� ������� �������� �������� truncate.

truncate table hurricane

------------------------------------------------------------------------------------------------------------------------------------
-- ������� ������� ��������.

drop table hurricane

