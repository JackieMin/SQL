------------------------------------------------------------------------------------------------------------------------------------
-- �������� �� ������ 16

-- �������� ����� pkg_agg_employees.
-- � ������ ���������� ���������, ������� �������� ������ � ������������ ��������� �����������, ������� � �����. 
-- �� ����� ������� ���������� ���������, ��������� �� ����� �������, ����������� ��������, ������������ �������� � ������� �������.

-- ��� ���� ���� � ��������� ������ ��������� ����� � ������� ����������� � ������� �������. 
-- ��������� - ����������� � ������� ������� listagg() � ������������ - ��������� ������� (chr(10)).

-- ��������� ��������� � ��������� ������ ���� �������� ���������� ���� ���������. 
-- ���������: ��� ���� ����� ���������� ��� ������ ���������, ����� ���������� ���� ��� ������� �� ������������ ������.

-- � ������ ���������� ������ �������� ����������� �������, ������� ���������� � ��������� �� ������� 2 � �� ��������� ���������� ������ �� ���� ��������� �������.

-- ���������� ������
create or replace package pkg_agg_employees
is          
    type agg_type is record (sum_salary NUMBER,
                             min_salary NUMBER,  
                             max_salary NUMBER,  
                             employees VARCHAR2(1024));

    type agg_tbl is table of agg_type; 

    procedure agg_proc (v_agg_tbl out agg_tbl); 
    
    function agg_func return agg_tbl pipelined;

end pkg_agg_employees;

-- ���� ������
create or replace package body pkg_agg_employees
is

    procedure agg_proc (v_agg_tbl out agg_tbl) 
    as
        cursor c_report
        is         
        select sum(alary) as sum_sal,
               min(salary) as min_sal,
               max(salary) as max_sal,
               listagg (first_name || ' ' || last_name || ', ' || chr(10)) WITHIN GROUP (ORDER BY dep.department_name) "employees"    
        from employees emp
        join departments dep on dep.department_id = emp.department_id
        join jobs j on j.job_id = emp.job_id
        group by dep.department_name
        ;
       begin
        open c_report;
            loop
                exit when c_report%notfound;
                fetch c_report bulk collect into v_agg_tbl limit 10000;
            end loop;
        close c_report;
    end agg_proc; 

   function agg_func return agg_tbl pipelined   
    as
        i number := 1;
        v_var pkg_agg_employees.agg_tbl;
        v_row pkg_agg_employees.agg_type;
     begin   
         pkg_agg_employees.agg_proc (v_var);
         for i in 1..v_var.count loop
            v_row: = null;
            v_row.sum_sal := v_var(i).sum_sal; 
            v_row.min_sal := v_var(i).min_sal; 
            v_row.max_sal := v_var(i).max_sal; 
            v_row.employees := v_var(i).employees; 
            pipe row (v_row);
         end loop;
      return;   
     end agg_func; 

end pkg_agg_employees; 
    

-- �������� ������ ������ ����������� �������.

select * from table(pkg_agg_employees.agg_func)


------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 16.

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �� ������� ����� �������� ���� � ��������� ����� � �� ���� �������� ��������� � �������� ������� � ������ 5 ��������.

select substr (country_name, 3, 5) as col1
from countries;


------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 ������������ ��������� ������� 1 � CLOB � �������� ������ ���� � ����� ������ CLOB �� ��������� �� ��������� ������. 
-- ����� ����� � ������� ������� �������� ���� �� ���������� ������ ���� �����.

select dbms_lob.compare (col1, col2) as compprator,
       col1,
       col2
from (select substr (to_clob(country_name), 3, 5) as col1,
             substr (to_clob(lead(country_name) over (order by country_id)),3,5) as col2
from countries);

------------------------------------------------------------------------------------------------------------------------------------
--  ������� 3 �������� ��������� prc_print_department_list, ������� �� ���� ��������� �������������� ��� ������ � ���������� � CLOB ������ �� �������, ��������� ������� �� �����.


create or replace PROCEDURE prc_print_department_list (p_country_id varchar2)
as
    v_result clob;
    
    cursor c_departments
    is
        select distinct
           dep.department_name
        from departments dep 
        join locations loc on loc.location_id = dep.location_id
        join countries c on c.country_id = loc.country_id
        where  c.country_id like '%'||p_country_id||'%';

begin 
    v_result := empty_clob();
    
    dbms_lob.createtemporary (v_result, true);
        
        for r in c_departments loop
            dbms_lob.append (v_result, r.department_name || chr(10));
        end loop;
    
    dbms_lob.freetemporary (v_result);
    
    dbms_output.put_line (v_result);
    
exception
   when others then
      dbms_lob.freetemporary (v_result);
      dbms_output.put_line (sqlerrm);

end prc_print_department_list;

exec prc_print_department_list('US');

select c.country_id,
       c.country_name,
       l.location_id,
       d.location_id,
       d.department_name
from countries c
join locations l on l.country_id = c.country_id
join departments d on d.location_id = l.location_id
where c.country_id = 'US';

select distinct
       d.department_name
from departments d 
join locations l on l.location_id = d.location_id
join countries c on c.country_id = l.country_id
where c.country_id = 'US';

------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 16.2

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ����� pkg_get_employees, � ������� �������� ����������� �������. � ������� ������ ���� �������� �� ��� ������������, 
-- �� �������� ����� ����� ����������� ������ �� ������ ����������� � �������. 

-- ����������� ������� ������ ���������� ��������� ����� �����: 
-- ������������� ����������, ���, �������, ����������� �����, ����� ��������, ��������, ������������ ������, �����.

create or replace package pkg_get_employees
is
    
    type get_emp_rec is record (id              number,
                                first_name      varchar2(20),                
                                last_name       varchar2(25),   
                                email           varchar2(25),                                   
                                phone           varchar2(20),  
                                salary          number,
                                department_name varchar2(30), 
                                city            varchar2(30));
                                
    type get_emp_tbl is table of get_emp_rec;
    
    function get_emp (p_department_id number) return get_emp_tbl pipelined;
    
end pkg_get_employees;

drop package pkg_get_employees;

create or replace package body pkg_get_employees
is
    function get_emp (p_department_id number) return get_emp_tbl pipelined
    is 
        v_get_emp_row get_emp_rec;
        
        cursor c_get_emp 
        is
        select e.EMPLOYEE_ID,
               e.FIRST_NAME,
               e.LAST_NAME,
               e.EMAIL,
               e.PHONE_NUMBER,
               e.SALARY,
               d.department_name,
               l.city
        from employees e 
        join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
        join LOCATIONS l on d.LOCATION_ID = l.LOCATION_ID
        where e.DEPARTMENT_ID = p_department_id
        order by l.city, 
                 e.last_name,
                 e.first_name;
begin 
    for r in c_get_emp loop
        v_get_emp_row := null;
        
        v_get_emp_row.ID := r.EMPLOYEE_ID;
        v_get_emp_row.FIRST_NAME := r.FIRST_NAME;
        v_get_emp_row.LAST_NAME := r.LAST_NAME;
        v_get_emp_row.EMAIL := r.EMAIL;
        v_get_emp_row.PHONE := r.PHONE_NUMBER;
        v_get_emp_row.SALARY := r.SALARY;
        v_get_emp_row.department_name := r.department_name;
        v_get_emp_row.city := r.city;       
        
        pipe row (v_get_emp_row);
    end loop;
    return;
end get_emp;    

end pkg_get_employees;


select e.EMPLOYEE_ID,
       e.FIRST_NAME,
       e.LAST_NAME,
       e.EMAIL,
       e.PHONE_NUMBER,
       e.SALARY,
       d.department_name,
       l.city
from employees e 
join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
join LOCATIONS l on d.LOCATION_ID = l.LOCATION_ID
--where e.DEPARTMENT_ID = p_depepartment_id
order by l.city, 
         e.last_name,
         e.first_name

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ������� ������ � ������ �� ����������� �������.

select * from table(pkg_get_employees.get_emp(100))
where last_name like 'C%';

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 3 �������� ������, �������������� �� ������ ����������� �������, ������� ������� ������� �� ����� �������, 
-- ���������� ����������� � ������� �������� � ������� �������.

select sum(salary),
       count(id),
       city
from table(pkg_get_employees.get_emp(100))
group by city;



------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 16.1

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ��������� prc_print_employee_card, ������� �� ���� ����� ��������� ��� ��������� ���� date. 
-- � ��������� ���������� ������ �� ������� ����������� � �����, � ������� ��� ���������� ��������. 
-- � ������� ���������� ���������� ������������� ������� �� ���� ���� ������ �� ������, �������������� ������� ������ ���� �������� � ���������. 
-- ��� ��������� ������ � ��������� ����� ������� �� ����� ������������ �����: ���, �������, �����, ��������.


create or replace PROCEDURE prc_print_employee_card (p_empdate date)
as
type employee_type is record (first_name varchar2(32),
                              last_name varchar2(32),
                              job_title varchar2(32),
                              salary number);
type employee_tbl is table of employee_type;

v_employee_tbl employee_tbl;

cursor c_emp 
is
select e.first_name, 
       e.last_name, 
       j.job_title, 
       e.salary
from employees e
     join jobs j on e.job_id = j.job_id
where e.hire_date like '%'||p_empdate||'%';

begin
open c_emp;
loop
    exit when c_emp%notfound;
    fetch c_emp bulk collect into v_employee_tbl limit 3;
    
    for i in 1..v_employee_tbl.count
    loop
        dbms_output.put_line(v_employee_tbl(i).first_name);  
    end loop;
end loop;

end;



------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ���� ������ ��������� �� ������� 1 � ��������� � ������� ������.

exec prc_print_employee_card(10.10.2005);

exec prc_print_employee_card(10.10.2005);

exec prc_print_employee_card(10.10.2005);

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 3 ���������� ��������� prc_print_employee_card ���, ����� ����������� ��� �������� ������� ������ �� ���������, �������������� � ������.


