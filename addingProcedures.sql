create or replace procedure add_client (cli_surname varchar, cli_name varchar, cli_phone_number varchar, cli_birthday date, cli_sex varchar) as $$ 
declare
seq_id_cli int; 
begin
select nextval('seq_cli') into seq_id_cli;
insert into client
values (seq_id_cli, cli_surname, cli_name, cli_phone_number, cli_birthday, cli_sex); 
exception 
when unique_violation then raise NOTICE 'Запись уже существует.'; 
end; 
$$ 
language plpgsql;

create or replace procedure add_post (post_name varchar, post_salary integer) as $$ 
declare
seq_id_post int; 
begin
select nextval('seq_post') into seq_id_post;
insert into post
values (seq_id_post, post_name, post_salary); 
exception 
when unique_violation then raise NOTICE 'Запись уже существует.'; 
end; 
$$ 
language plpgsql;

create or replace procedure add_service (serv_name varchar, serv_time integer, serv_cost integer) as $$ 
declare
seq_id_serv int; 
begin
select nextval('seq_serv') into seq_id_serv;
insert into service
values (seq_id_serv, serv_name, serv_time, serv_cost); 
exception 
when unique_violation then raise NOTICE 'Запись уже существует.'; 
end; 
$$ 
language plpgsql;

create or replace procedure add_employee (emp_surname varchar, emp_name varchar, emp_phone_number varchar, emp_birthday date, emp_sex varchar, emp_address varchar, emp_post varchar) as $$ 
declare
seq_id_emp int; 
id_post_emp int;
begin
select p.id_post 
from post p
where p.post_name = emp_post into id_post_emp;
select nextval('seq_emp') into seq_id_emp;
insert into employee
values (seq_id_emp, emp_surname, emp_name, emp_phone_number, emp_birthday, emp_sex, emp_address, id_post_emp); 
exception 
when unique_violation then raise NOTICE 'Запись уже существует.'; 
end; 
$$ 
language plpgsql;

create or replace procedure add_post_serv (name_post varchar, name_serv varchar) as $$ 
declare
serv int; 
post int;
begin
select p.id_post 
from post p
where p.post_name = name_post into post;
select s.id_service
from service s
where s.serv_name = name_serv into serv;
insert into post_service
values (post, serv); 
exception 
when unique_violation then raise NOTICE 'Запись уже существует.'; 
end; 
$$ 
language plpgsql;

create or replace procedure add_record (name_serv varchar, surname_emp varchar, surname_cli varchar, re_date date, re_time time) as $$ 
declare
seq_id_re int;
serv int; 
emp int;
cli int;
begin
select s.id_service
from service s
where s.serv_name = name_serv into serv;
select e.id_employee 
from employee e
where e.emp_surname = surname_emp into emp;
select c.id_client 
from client c
where c.cli_surname = surname_cli into cli;
select nextval('seq_re') into seq_id_re;
insert into record (id_record, re_id_serv, re_id_emp, re_id_cli, re_date, re_time)
values (seq_id_re, serv, emp, cli, re_date, re_time); 
exception 
when unique_violation then raise NOTICE 'Запись уже существует.'; 
end; 
$$ 
language plpgsql;



