------------------------------------------------------------------------------------------------------------------------------------
-- Практика по модулю 14

------------------------------------------------------------------------------------------------------------------------------------
-- 1. Создайте пакет pkg_job_description, в котором будут функция get_mean_salary и процедуры print_employee_name и get_min_max_salary.

create or replace PACKAGE pkg_job_description
as
    PROCEDURE get_min_max_salary   (p_job_id IN VARCHAR2,
                                    p_min_sal out number,
                                    p_max_sal out number);

    FUNCTION get_mean_salary       (p_min_sal in number,
                                    p_max_sal in number) return number;   

    PROCEDURE print_employee_name  (p_employee_id IN number);  
    
end pkg_job_description;

------------------------------------------------------------------------------------------------------------------------------------
-- 2. Процедуру get_min_max_salary, которая возвращает (с помощью параметров на выход) минимальную и максимальную суммы зарплат по идентификатору работы (передаётся параметром)

create or replace PACKAGE body pkg_job_description
as
    PROCEDURE get_min_max_salary (p_job_id IN VARCHAR2,
                                  p_min_sal out number,
                                  p_max_sal out number)
    as
        min_sal number;
        max_sal number;
    begin
        select min_salary,
               max_salary into 
                          min_sal,
                          max_sal
        from jobs
        where job_id = p_job_id; 
        p_min_sal := min_sal;
        p_max_sal := max_sal;
    end get_min_max_salary;      
    
    FUNCTION get_mean_salary (p_min_sal in number,
                              p_max_sal in number) return number
        as
            result number;
        begin  
            result := (p_min_sal + p_max_sal) / 2;
            return result;
        end get_mean_salary;

    PROCEDURE print_employee_name (p_employee_id IN number)
    as
        full_name varchar2(32);
        emp_job_id varchar2(10);
        min_sal number;
        max_sal number;
    begin
        select e.first_name || ' ' || e.last_name, 
               e.job_id      
               into full_name,
                    emp_job_id   
               from employees e
        where e.EMPLOYEE_ID = p_employee_id; 
        get_min_max_salary(p_job_id =>emp_job_id,
                           p_min_sal => min_sal,
                           p_max_sal => max_sal);
        dbms_output.put_line(full_name || ': ' || 'минимальная зп - ' || min_sal || ', ' ||'максимальная зп - ' || max_sal);
    end print_employee_name;  
    
end pkg_job_description;

------------------------------------------------------------------------------------------------------------------------------------
-- 3. Создайте функцию get_mean_salary, которая принимает два значения зарплат и возвращает их среднее значение.
-- см. задание 2

------------------------------------------------------------------------------------------------------------------------------------
-- 4. Процедура print_employee_name, которая выводит на экран полное имя сотрудника (его идентификатор передается в параметре) и то что возвращает процедура get_min_max_salary по идентификатору работы этого сотрудника.
-- см. задание 2

------------------------------------------------------------------------------------------------------------------------------------
-- 5. Создайте запрос для запуска процедуры get_min_max_salary.

declare 
    min_sal number;
    max_sal number;
begin
    pkg_job_description.get_min_max_salary(p_job_id =>'PU_CLERK',
                              p_min_sal => min_sal,
                              p_max_sal => max_sal);
    dbms_output.put_line(min_sal ||  '    ' ||  max_sal);
end;

------------------------------------------------------------------------------------------------------------------------------------
-- 6. Создайте анонимный блок вызова процедуры print_employee_name.

EXEC pkg_job_description.print_employee_name(102);






------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 14.5

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создайте пакет pkg_print_dates.

create or replace PACKAGE pkg_print_dates
as
    FUNCTION get_date RETURN date;
    PROCEDURE print_date;
end pkg_print_dates;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Создайте функцию get_date в пакете, которая возвращает текущую дату.

create or replace PACKAGE body pkg_print_dates
as
    FUNCTION get_date return date
        as
            result date;
        begin
            result := sysdate;
            return result;
    end get_date;
    
    PROCEDURE print_date
        as
        begin
            dbms_output.put_line(to_char(get_date, 'dd.mm.yyyy'));
    end print_date;
end pkg_print_dates;


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Создайте процедуру print_date в пакете, которая берет дату из функции get_date и выводит ее результат на экран.
-- см. задание 2

begin
    pkg_print_dates.print_date;
end;


------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 14.4

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создайте функцию get_salary, которая принимает на вход параметры: наименование отдела, по-умолчанию ИТ. и возвращает сумму зарплат отдела. Также переопределяется выходной параметр наименования отдела.

create or replace FUNCTION get_salary (dep_name in out varchar2) return number
as
    dep_sum_salary number;                                       
begin
    select sum(e.salary) into dep_sum_salary
    from employees e
    join departments d on e.department_id = d.department_id 
    where d.department_name = dep_name;    
    dep_name := 'Administration';
    return dep_sum_salary;
end;


------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Создайте анонимный блок вызова функции из задания 1, который выводит на экран результат функции и то, что возвращает переопределенный параметр.

declare
    dep_name varchar2(32);
begin
    dep_name := 'IT';
    dbms_output.put_line(get_salary(dep_name) || ' ' || dep_name);
end;





------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 14.3

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создайте функцию get_datestamp, которая возвращает текстовый штамп текущей даты.

create or replace FUNCTION get_datestamp return VARCHAR2
as
    result varchar2(32);
begin
    result := to_char(sysdate, 'dd.mm.yyyy hh24:mm:ss');
    return result;
end;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Создайте анонимный блок вызова этой функции с выводом результата функции на экран.

begin
    dbms_output.put_line(get_datestamp);
end;

declare 
    v_date varchar2(32);
begin
    v_date := get_datestamp;
    dbms_output.put_line(v_date);
end;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Напишите запрос, который вызывает функцию из задания 1.

select get_datestamp as now_date from dual;






------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 14.2

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создайте процедуру print_parameters с двумя параметрами разных типов, которая выводит на экран конкатенированные названия параметров с их значениями.

create or replace PROCEDURE print_parameters (p_first number DEFAULT 1,
                                              p_second varchar2 DEFAULT 'второй') 
as
begin
    dbms_output.put_line('Значение параметра p_first = ' || p_first|| ', ' || 'а значение параметра p_second = ' || p_second);
end;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Создайте процедуру arithmetic_progression, делающую арифметическую последовательность с тремя параметрами. Первый - член прогрессии, второй - шаг прогрессии, третий - ограничение количества шагов прогрессии. 
-- Процедура должна выводить на экран результат прогрессии.

create or replace PROCEDURE arithmetic_progression (p_member number DEFAULT 1,
                                                    p_step number DEFAULT 2,
                                                    p_cnt number DEFAULT 3) 
as
    result number;
begin
    for r in 1..p_cnt loop
        if result is null then 
            result := p_member;
            dbms_output.put_line(result || chr(10));
        else 
            result := result + p_step;
            dbms_output.put_line(result || chr(10));            
        end if;
    end loop;    
end;

exec arithmetic_progression;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Создайте анонимные блоки вызова процедур из задания 1 и задания 2.

begin
    print_parameters (5, 'five');
end;

begin
    arithmetic_progression (5,5,5);
end;





------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 14.1

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создайте процедуру print_my_name, которая выводит на экран Ваше имя.

create PROCEDURE print_my_name 
AS
begin
    dbms_output.put_line('Евгения Минакова');
end;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Создайте процедуру print_datetime, которая выводит на экран текущую дату и время.

create PROCEDURE print_datetime 
AS
begin
    dbms_output.put_line(to_char(sysdate, 'dd.mm.yyyy hh24:mm:ss'));
end;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Создайте анонимный блок вызова процедур из задания 1 и задания 2.

begin
    print_my_name;
    print_datetime;
end;