------------------------------------------------------------------------------------------------------------------------------------
-- Практика по модулю 16

-- Напишите пакет pkg_agg_employees.
-- В пакете реализуйте процедуру, которая содержит курсор с соединенными таблицами сотрудников, отделов и работ. 
-- По этому курсору собирается коллекция, состоящая из суммы зарплат, минимальной зарплате, максимальной зарплате в разрезе отделов.

-- Еще одно поле в коллекции должно содержать имена и фамилии сотрудников в разрезе отделов. 
-- Подсказка - используйте в курсоре функцию listagg() с разделителем - переводом каретки (chr(10)).

-- Собранная коллекция в процедуре должна быть выходным параметром этой процедуры. 
-- Подсказка: для того чтобы определить тип данных параметра, нужно подставить туда тип таблицы из спецификации пакета.

-- В рамках созданного пакета создайте конвейерную функцию, которая обращается к процедуре из задания 2 и по конвейеру отправляет данные из этой коллекции запросу.

-- Объявление пакета
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

-- Тело пакета
create or replace package body pkg_agg_employees
is

    procedure agg_proc (v_agg_tbl out agg_tbl) 
    as
        cursor c_report
        is         
        select sum(salary) as sum_sal,
               min(salary) as min_sal,
               max(salary) as max_sal,
--             listagg (first_name || ' ' || last_name || ', ' || chr(10)) WITHIN GROUP (ORDER BY dep.department_name) "employees"
               listagg (first_name || ' ' || last_name || ', ' || chr(10)) WITHIN GROUP (ORDER BY dep.department_name) AS employees
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

    function agg_func return agg_tbl pipelined as
       v_var pkg_agg_employees.agg_tbl;
    begin   
       agg_proc(v_var);
       for i in v_var.first..v_var.last loop
           pipe row (v_var(i));
       end loop;
       return;   
    end agg_func; 

end pkg_agg_employees; 


-- Напишите запрос вызова конвейерной функции.

select * from table(pkg_agg_employees.agg_func);


------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 16.

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 �?з таблицы стран выберите поле с названием стран и из него выберите подстроку с третьего символа с длиной 5 символов.

select substr (country_name, 3, 5) as col1
from countries;


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Преобразуйте результат задания 1 в CLOB и сделайте второе поле с типом данных CLOB со значением из следующей строки. 
-- После этого в верхнем запросе добавьте поле со сравнением первых двух полей.

select dbms_lob.compare (col1, col2) as compprator,
       col1,
       col2
from (select substr (to_clob(country_name), 3, 5) as col1,
             substr (to_clob(lead(country_name) over (order by country_id)),3,5) as col2
from countries);

------------------------------------------------------------------------------------------------------------------------------------
--  Задание 3 Напишите процедуру prc_print_department_list, которая на вход принимает двухсимвольный код страны и записывает в CLOB данные по отделам, результат вывести на экран.


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
-- Практика урока 16.2

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Напишите пакет pkg_get_employees, в котором напишите конвейерную функцию. У функции должен быть параметр на код департамента, 
-- по которому нужно будет фильтровать запрос из таблиц сотрудников и отделов. 

-- Конвейерная функция должна возвращать следующий набор полей: 
-- идентификатор сотрудника, имя, фамилия, электронная почта, номер телефона, зарплата, наименование отдела, город.

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
-- Задание 2 Напишите простой запрос к данным из конвейерной функции.

select * from table(pkg_get_employees.get_emp(100))
where last_name like 'C%';

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Напишите запрос, основывающийся на данных конвейерной функции, который создает агрегат по сумме зарплат, 
-- количестве сотрудников и средней зарплате в разрезе городов.

select sum(salary),
       count(id),
       city
from table(pkg_get_employees.get_emp(100))
group by city;



------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 16.1

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Напишите процедуру prc_print_employee_card, которая на вход будет принимать два параметра типа date. 
-- В процедуре реализуйте курсор по таблице сотрудников и стран, в которых эти сотрудники работают. 
-- С помощью параметров необходимо отфильтровать выборку по полю даты приема на работу, результирующая выборка должна быть положена в коллекцию. 
-- При обработке данных в коллекции нужно вывести на экран конкатенацию полей: �?мя, Фамилия, Город, Зарплата.


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
-- Задание 2 Напишите блок вызова процедуры из задания 1 и запустите с разными датами.

exec prc_print_employee_card(10.10.2005);

exec prc_print_employee_card(10.10.2005);

exec prc_print_employee_card(10.10.2005);

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Перепишите процедуру prc_print_employee_card так, чтобы попробовать все варианты условий циклов по коллекции, представленных в лекции.


