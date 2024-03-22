create table public.client (id_client int default nextval('seq_cli') constraint pk_client primary key,
cli_surname varchar(20) not null,
cli_name varchar(20),
cli_phone_number varchar(13) not null,
cli_birthday date,
cli_sex varchar(10),
unique(cli_surname, cli_phone_number));

create table public.post(id_post int default nextval('seq_post') constraint pk_post primary key,
post_name varchar(30) not null unique,
post_salary int constraint s_post_salaty check (post_salary > 0));

create table public.employee(id_employee int default nextval('seq_emp') constraint pk_employee primary key,
emp_surname varchar(20) not null,
emp_name varchar(20),
emp_phone_number varchar(13) not null,
emp_birthday date constraint check_age check (emp_birthday < (current_date - interval '18' year )),
emp_sex varchar(10),
emp_address varchar(50),
emp_post int not null,
unique(emp_surname, emp_name, emp_post),
foreign key (emp_post) references post (id_post));

create table public.service(id_service int default nextval('seq_serv') constraint pk_service primary key,
serv_name varchar(30) not null unique,
serv_time int,
serv_cost int);

create table public.post_service(id_post int,
foreign key (id_post) references post(id_post),
id_service int,
foreign key(id_service) references service(id_service),
primary key (id_post,id_service));

create table public.record(id_record int default nextval('seq_re') constraint pk_record primary key,
re_id_serv int not null,
foreign key (re_id_serv) references service (id_service),
re_id_emp int not null,
foreign key (re_id_emp) references employee (id_employee),
re_id_cli int not null, 
foreign key (re_id_cli) references client (id_client),
re_date date not null constraint actual_data check (re_date >= current_date),
re_time time not null,
re_confirmation boolean default '0' not null);



