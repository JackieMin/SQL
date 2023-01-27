------------------------------------------------------------------------------------------------------------------------------------
-- �������� �� ������ 15

/* �������� ��������� ����, ������� ����� ������������ � ����� �� ��������� ����������� ������ �� ������� �����������, �������� � ������� ����� �� �����.
��� ������ ������ �� ������� ���������� �������� �� ����� ������������ ����� ������ ����� ���, �������, ���������� �����.
� ����������� �� �������� ���������� �����, ����� ������� ��������� �� �����, ����� �������� ����� 'LOW' ��� 'OK', ��� 'HIGH'.
� ������, ���� ���������� ����� ����� ����� 1000, ����� ����� ������ ���������������� ����������, � � ����� ������ ������� ������������ ����� ������ ����� ���, �������, ���������� ����� � ������ 'TOOOOO LOW'. 
�������� ���������� ����� ��� ��������� ���������� ��������� �������������� � ��������� 1 ����� LOW, 2 ����� OK, 1 ����� HIGH. */

declare
    cursor c_emp (p_dep varchar2)
    is
    select last_name,
           first_name,
           salary
    from   employees e
    join departments d on d.department_id = e.department_id
    where d.department_name like '%'||p_dep||'%'
    order by 1;    
    lable varchar2(16);
    out_of_range exception;
    pragma exception_init(out_of_range, -20001);    
begin
    for c in c_emp ('Shipping') loop
        if    c.salary >= 10000 then 
              lable := 'HIGH';
              dbms_output.put_line(c.last_name || ' ' || c.first_name || ', salary = ' || c.salary || '$ (' || lable || ')');
        elsif c.salary > 3000 and c.salary < 10000 then 
              lable := 'OK';
              dbms_output.put_line(c.last_name || ' ' || c.first_name || ', salary = ' || c.salary || '$ (' || lable || ')');
        elsif c.salary > 1000 and c.salary <= 3000 then 
              lable := 'LOW';
              dbms_output.put_line(c.last_name || ' ' || c.first_name || ', salary = ' || c.salary || '$ (' || lable || ')');
        end if;
        
        if c.salary = 1000 then 
             raise_application_error (-20001, 'TOOOOO LOW');       
        end if;        
        
        c.last_name := null;
        c.first_name := null;
        c.salary := null;            
    end loop;
end;

------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 15.3

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ��������� prc_define_dict, � ������� ����� ��������� - �������� ������� � ���� ������� ��� �������� ���� �������.

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ������������ SQL, ������� ����� ��������� ������� � ��������� �� ��������� � ���������: updated_at � ����� ����, id � �������� ����� � char_code � ��������� ����� �����.

------------------------------------------------------------------------------------------------------------------------------------
--  ������� 3 �������� ������������ SQL, ������� ����� �������� truncate ���� �������.

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 4 �������� ������������ SQL, ������� ��������� ������ � ������� � ������ �N/A� � �N/D�, ���������������� 0 � -1, ��������������. �� ��������� ������������� ��������� ����������.

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 5 �������� ������������� �������� ������� ��� ������� �� � ����������� �� ������� ���������.

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 6 ������������ ��������� � ������� ����������� � ���������� �� ���������� ������ ����� ��������� � ������� ������� �������� � ��������� ��������.

create or replace PROCEDURE hr.prc_define_dict (p_table_name varchar2,
                                                p_flag number) 
as
begin
    EXECUTE IMMEDIATE 'create table ' || p_table_name || ' (updated_at date,
                                                            id number,
                                                            char_code varchar2(16)) ';
    if p_flag = 1 then 
        EXECUTE IMMEDIATE 'insert into ' || p_table_name || '  (updated_at,
                                                                id,
                                                                char_code)
                                                        values (sysdate,
                                                                0,
                                                                ''N/A'') ';
        EXECUTE IMMEDIATE 'insert into ' || p_table_name || '  (updated_at,
                                                                id,
                                                                char_code)
                                                        values (sysdate,
                                                                -1,
                                                                ''N/D'') ';
    elsif p_flag = 0 then 
        EXECUTE IMMEDIATE 'truncate table ' || p_table_name ;   
    else 
        dbms_output.put_line('Flag is nor correct');
    end if;    
end;

exec hr.prc_define_dict ('TEST_TABLE', 3);
                         
select * from test_table;   

drop table test_table

grant create any table to hr;


------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 15.2

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ��������� ����, � ������� ����� ������� ������ � ������� ����������� � �������� ���� ����������� ������ IT �� �����.

begin
    for e in (select last_name from employees where job_id = 'IT_PROG') loop
        dbms_output.put_line(e.last_name);
    end loop;
end;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 �������� ��������� ����, � ������� ����� ����������� ������ � ������� ����� � �������� �������� ����� � �� �������������� �� �����. 
-- ��� ���� ����������� ��������� ��� ������ ��� ���������� �������. � ����������� ���� � ������� ���������� ���, ����� ��������� ������ �� �����������.

declare
    cursor c_cnt (p_text varchar2)
    is
    select country_name,
           COUNTRY_ID 
    from   countries
    where country_name like '%'||p_text||'%';
    
begin
    
    for c in c_cnt ('A') loop
        dbms_output.put_line(c.country_id || ' ' || c.country_name);
        c.country_id := null;
        c.country_name := null;
    end loop;

end;

declare
    cursor c_cnt
    is
    select country_name,
           COUNTRY_ID 
    from   countries;

begin
    
    for c in c_cnt loop
        dbms_output.put_line(c.country_id || ' ' || c.country_name);
        c.country_id := null;
        c.country_name := null;
    end loop;

end;


declare
    cursor c_cnt
    is
    select country_name,
           COUNTRY_ID 
    from   countries;
    
    v_row c_cnt%rowtype;
begin
    open c_cnt;
    
    loop
        exit when c_cnt%notfound;
        
        fetch c_cnt into v_row;
        dbms_output.put_line(v_row.country_id || ' ' || v_row.country_name);
        v_row.country_id := null;
        v_row.country_name := null;
    end loop;
    
    close c_cnt;
end;


declare
    cursor c_cnt
    is
    select country_name,
           COUNTRY_ID 
    from   countries;
    
    c_name varchar2(40);
    c_id CHAR(2);
begin
    open c_cnt;
    
    loop
        exit when c_cnt%notfound;
        
        fetch c_cnt into c_name, c_id;
        dbms_output.put_line(c_name || ' ' || c_id);
        c_name := null;
        c_id := null;
    end loop;
    
    close c_cnt;
end;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 3 �������� ��������� ����, � ������� ����� ����������� ������ � ������� ������� � ���������� ������� (������������ ������� ������� ���������� �����������), 
-- �������� �������� ������, ��������� � ���������� �����������.


declare
    cursor c_cnt (p_text varchar2)
    is
    select country_name,
           COUNTRY_ID 
    from   countries
    where country_name like '%'||p_text||'%';
    
begin
    
    for c in c_cnt ('A') loop
        dbms_output.put_line(c.country_id || ' ' || c.country_name);
        c.country_id := null;
        c.country_name := null;
    end loop;

end;

declare 
    cursor c_dep (p_city varchar2)
    is
    select  dp.department_name as dep,
            e.last_name || ' ' || e.first_name as manag,            
            count(e2.employee_id) as cnt_emp            
    from employees e        
        left join departments dp on dp.manager_id = e.employee_id
        left join employees e2 on e2.department_id = dp.department_id
        left join locations l on l.location_id = dp.location_id
    where l.city like '%'||p_city||'%'
    group by dp.department_name, e.last_name || ' ' || e.first_name;   

begin
    
    for c in c_dep ('Seattle') loop
        dbms_output.put_line('����������� - ' || c.dep || ', ������������ - ' || c.manag || ', ���-�� ����������� - ' || c.cnt_emp);
        c.dep := null;
        c.manag := null;
        c.cnt_emp :=null;
    end loop; 
end;






------------------------------------------------------------------------------------------------------------------------------------
-- �������� ����� 15.1

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 1 �������� ��������� ����, � ������� ����� �������� ������ � ������� �������� ��� ������� � ������������ ������������ ������� � ����������. 
-- ���������� ������������ ����������� ���������� � no_data_found, too_many_rows � others.

declare
    v_result VARCHAR2(23);
begin
        select REGION_NAME
        into   v_result
        from   regions;     
    dbms_output.put_line('��������� ������ - ' || v_result);
EXCEPTION
    when too_many_rows then 
    dbms_output.put_line('������� ����� �����');
end;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 2 � ������� � ������� �������� �� ������� 1 �������� ������� ���������� �� �������������� ��������������� �������.

declare
    v_result VARCHAR2(23);
begin
        select REGION_NAME
        into   v_result
        from   regions
        where  region_id = 5;     
    dbms_output.put_line('��������� ������ - ' || v_result);
EXCEPTION
    when no_data_found then 
    dbms_output.put_line('������ �� ������');
end;

------------------------------------------------------------------------------------------------------------------------------------
-- ������� 3 �������� ��������� prc_calc_amperage, ������� ��������� �� ���� ��� ��������� � ���������� � �������������, ����� �������������� �� ������� ��� ���� ����. 
-- � ������� ���������� ���������� ����������� ���������� (invalid_number, value_error, zero_devide, others) � ���� ����������������, ����� ���� ���� ����� 1 �.

create or replace PROCEDURE prc_calc_amperage (U number DEFAULT 5,
                                               R number DEFAULT 5) 
as
    I number;
    out_of_range exception;
    pragma exception_init(out_of_range, -20001);
begin
    I := U / R;
    if I = 1 then 
       raise_application_error (-20001, '���� ���� ������� �������!');
       else  dbms_output.put_line('���� ���� = ' || I*1000 || ' �A');   
    end if;   
EXCEPTION
    when invalid_number then
         dbms_output.put_line('�������� �������������� ������ � �����');
    
    when zero_divide then
         dbms_output.put_line('������� �� ���� ����������!');
    
    when others then
         dbms_output.put_line(sqlerrm);
end;

exec prc_calc_amperage;
