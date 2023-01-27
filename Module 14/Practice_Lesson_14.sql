------------------------------------------------------------------------------------------------------------------------------------
-- �������� �� ������ 14

------------------------------------------------------------------------------------------------------------------------------------
-- 1. �������� ����� pkg_job_description, � ������� ����� ������� get_mean_salary � ��������� print_employee_name � get_min_max_salary.

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
-- 2. ��������� get_min_max_salary, ������� ���������� (� ������� ���������� �� �����) ����������� � ������������ ����� ������� �� �������������� ������ (��������� ����������)

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
        dbms_output.put_line(full_name || ': ' || '����������� �� - ' || min_sal || ', ' ||'������������ �� - ' || max_sal);
    end print_employee_name;  
    
end pkg_job_description;

------------------------------------------------------------------------------------------------------------------------------------
-- 3. �������� ������� get_mean_salary, ������� ��������� ��� �������� ������� � ���������� �� ������� ��������.
-- ��. ������� 2

------------------------------------------------------------------------------------------------------------------------------------
-- 4. ��������� print_employee_name, ������� ������� �� ����� ������ ��� ���������� (��� ������������� ���������� � ���������) � �� ��� ���������� ��������� get_min_max_salary �� �������������� ������ ����� ����������.
-- ��. ������� 2

------------------------------------------------------------------------------------------------------------------------------------
-- 5. �������� ������ ��� ������� ��������� get_min_max_salary.

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
-- 6. �������� ��������� ���� ������ ��������� print_employee_name.

EXEC pkg_job_description.print_employee_name(102);






------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 14.5

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ����� pkg_print_dates.

create or replace PACKAGE pkg_print_dates
as
    FUNCTION get_date RETURN date;
    PROCEDURE print_date;
end pkg_print_dates;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ������� get_date � ������, ������� ���������� ������� ����.

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
-- ������� 3 �������� ��������� print_date � ������, ������� ����� ���� �� ������� get_date � ������� �� ��������� �� �����.
-- ��. ������� 2

begin
    pkg_print_dates.print_date;
end;


------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 14.4

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ������� get_salary, ������� ��������� �� ���� ���������: ������������ ������, ��-��������� ��. � ���������� ����� ������� ������. ����� ���������������� �������� �������� ������������ ������.

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
-- ������� 2 �������� ��������� ���� ������ ������� �� ������� 1, ������� ������� �� ����� ��������� ������� � ��, ��� ���������� ���������������� ��������.

declare
    dep_name varchar2(32);
begin
    dep_name := 'IT';
    dbms_output.put_line(get_salary(dep_name) || ' ' || dep_name);
end;





------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 14.3

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ������� get_datestamp, ������� ���������� ��������� ����� ������� ����.

create or replace FUNCTION get_datestamp return VARCHAR2
as
    result varchar2(32);
begin
    result := to_char(sysdate, 'dd.mm.yyyy hh24:mm:ss');
    return result;
end;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ��������� ���� ������ ���� ������� � ������� ���������� ������� �� �����.

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
-- ������� 3 �������� ������, ������� �������� ������� �� ������� 1.

select get_datestamp as now_date from dual;






------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 14.2

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ��������� print_parameters � ����� ����������� ������ �����, ������� ������� �� ����� ����������������� �������� ���������� � �� ����������.

create or replace PROCEDURE print_parameters (p_first number DEFAULT 1,
                                              p_second varchar2 DEFAULT '������') 
as
begin
    dbms_output.put_line('�������� ��������� p_first = ' || p_first|| ', ' || '� �������� ��������� p_second = ' || p_second);
end;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ��������� arithmetic_progression, �������� �������������� ������������������ � ����� �����������. ������ - ���� ����������, ������ - ��� ����������, ������ - ����������� ���������� ����� ����������. 
-- ��������� ������ �������� �� ����� ��������� ����������.

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
-- ������� 3 �������� ��������� ����� ������ �������� �� ������� 1 � ������� 2.

begin
    print_parameters (5, 'five');
end;

begin
    arithmetic_progression (5,5,5);
end;





------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 14.1

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ��������� print_my_name, ������� ������� �� ����� ���� ���.

create PROCEDURE print_my_name 
AS
begin
    dbms_output.put_line('������� ��������');
end;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ��������� print_datetime, ������� ������� �� ����� ������� ���� � �����.

create PROCEDURE print_datetime 
AS
begin
    dbms_output.put_line(to_char(sysdate, 'dd.mm.yyyy hh24:mm:ss'));
end;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 3 �������� ��������� ���� ������ �������� �� ������� 1 � ������� 2.

begin
    print_my_name;
    print_datetime;
end;