------------------------------------------------------------------------------------------------------------------------------------
-- Практика по модулю 15

/* Создайте анонимный блок, который будет использовать в цикле по коллекции именованный курсор по таблице сотрудников, параметр у курсора будет на отдел.
Для каждой строки из курсора необходимо выводить на экран конкатенацию через пробел полей имя, фамилия, заработная плата.
В зависимости от значения заработной платы, перед выводом сообщения на экран, нужно добавить метку 'LOW' или 'OK', или 'HIGH'.
В случае, если заработная плата будет равна 1000, нужно будет выдать пользовательское исключение, а в текст ошибки сложить конкатенацию через пробел полей имя, фамилия, заработная плата и меткой 'TOOOOO LOW'. 
Значения заработной платы для ветвления необходимо подобрать самостоятельно в пропорции 1 часть LOW, 2 части OK, 1 часть HIGH. */

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
-- Практика урока 15.3

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создайте процедуру prc_define_dict, в которой будут параметры - название таблицы и флаг очистки или создания этой таблицы.

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Напишите динамический SQL, который будет создавать таблицу с названием из параметра и столбцами: updated_at с типом дата, id с числовым типом и char_code с текстовым типом кодом.

------------------------------------------------------------------------------------------------------------------------------------
--  Задание 3 Напишите динамический SQL, который будет вызывать truncate этой таблицы.

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 4 Напишите динамический SQL, который вставляет строки в таблицу с кодами ‘N/A’ и ‘N/D’, идентификаторами 0 и -1, соответственно. Не забывайте зафиксировать результат транзакции.

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 5 Сделайте переключатель создания таблицы или очистки ее в зависимости от второго параметра.

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 6 Позапускайте процедуру с разными параметрами и посмотрите на результаты работы вашей процедуры с помощью простых запросов к созданным таблицам.

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
-- Практика урока 15.2

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Напишите анонимный блок, в котором будет неявный курсор к таблице сотрудников и выведите всех сотрудников отдела IT на экран.

begin
    for e in (select last_name from employees where job_id = 'IT_PROG') loop
        dbms_output.put_line(e.last_name);
    end loop;
end;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 Напишите анонимный блок, в котором будет именованный курсор к таблице стран и выведите названия стран и их идентификаторы на экран. 
-- При этом используйте ссылочный тип данных для результата курсора. И используйте цикл с выходом посередине так, чтобы последняя строка не повторялась.

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
-- Задание 3 Напишите анонимный блок, в котором будет именованный курсор к таблице отделов с параметром локации (присоедините таблицу локаций внутренним соединением), 
-- выведите название отдела, менеджера и количество сотрудников.


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
        dbms_output.put_line('Департамент - ' || c.dep || ', Руководитель - ' || c.manag || ', Кол-во сотрудников - ' || c.cnt_emp);
        c.dep := null;
        c.manag := null;
        c.cnt_emp :=null;
    end loop; 
end;






------------------------------------------------------------------------------------------------------------------------------------
-- Практика урока 15.1

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 1 Создайте анонимный блок, в котором будет делаться запрос к таблице регионов без условий и складываться наименование региона в переменную. 
-- Необходимо обрабатывать стандартные исключения — no_data_found, too_many_rows и others.

declare
    v_result VARCHAR2(23);
begin
        select REGION_NAME
        into   v_result
        from   regions;     
    dbms_output.put_line('Найденный регион - ' || v_result);
EXCEPTION
    when too_many_rows then 
    dbms_output.put_line('Слишком много строк');
end;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 2 В запросе к таблице регионов из задания 1 добавьте условие фильтрации по идентификатору несуществующего региона.

declare
    v_result VARCHAR2(23);
begin
        select REGION_NAME
        into   v_result
        from   regions
        where  region_id = 5;     
    dbms_output.put_line('Найденный регион - ' || v_result);
EXCEPTION
    when no_data_found then 
    dbms_output.put_line('Регион не найден');
end;

------------------------------------------------------------------------------------------------------------------------------------
-- Задание 3 Создайте процедуру prc_calc_amperage, которая принимает на вход два параметра — напряжение и сопротивление, далее рассчитывается по формуле Ома сила тока. 
-- В функции необходимо обработать стандартные исключения (invalid_number, value_error, zero_devide, others) и одно пользовательское, когда сила тока равна 1 А.

create or replace PROCEDURE prc_calc_amperage (U number DEFAULT 5,
                                               R number DEFAULT 5) 
as
    I number;
    out_of_range exception;
    pragma exception_init(out_of_range, -20001);
begin
    I := U / R;
    if I = 1 then 
       raise_application_error (-20001, 'Сила тока слишком большая!');
       else  dbms_output.put_line('Сила тока = ' || I*1000 || ' мA');   
    end if;   
EXCEPTION
    when invalid_number then
         dbms_output.put_line('Неверное преобразование строки в число');
    
    when zero_divide then
         dbms_output.put_line('Деление на ноль невозможно!');
    
    when others then
         dbms_output.put_line(sqlerrm);
end;

exec prc_calc_amperage;
