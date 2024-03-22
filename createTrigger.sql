create or replace trigger tr_insert_record after insert on record
for each row
execute function add_re_confirmation();


create or replace function add_re_confirmation() returns trigger as $$
declare CNT int;
inter_time int; 
post int;
tmp int;
begin
 select s.serv_time from service s
 where s.id_service = new.re_id_serv into inter_time;
 select e.emp_post from employee e
 where e.id_employee = new.re_id_emp into post;
 select count(ps.id_service) from post_service ps
 where (ps.id_service = new.re_id_serv and ps.id_post = post) into tmp;
 select count(r.re_confirmation) as count_conf
 from record r
 where r.re_confirmation = '1' and r.re_date = new.re_date and    (r.re_time = new.re_time or (r.re_time + (inter_time * interval '1    minute' )) > new.re_time ) and (r.re_id_cli = new.re_id_cli or
r.re_id_emp = new.re_id_emp) INTO CNT;
 if (CNT = 0 and tmp = 1) then 
  update record set re_confirmation = '1' where id_record = new.id_record;
 end if;
 return NULL;
end
$$
language plpgsql;

