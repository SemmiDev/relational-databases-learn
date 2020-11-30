create table if not exists tb_data_test_types(
    age smallint
);

insert into tb_data_test_types (age) values (32767);
select * from tb_data_test_types;
alter table tb_data_test_types ADD COLUMN IF NOT EXISTS rank integer;

insert into tb_data_test_types (age, rank) values (32767,1231);
select * from tb_data_test_types;

alter table tb_data_test_types ADD COLUMN IF NOT EXISTS price numeric;
insert into tb_data_test_types (age,rank,price) values (1,2,120000);
select * from tb_data_test_types;

alter table tb_data_test_types ADD COLUMN IF NOT EXISTS price_up real;
insert into tb_data_test_types (age,rank,price,price_up) values (1,2,3,1122000000000);
select * from tb_data_test_types;
drop table tb_data_test_types;

create table if not exists barang(
    id_barang integer primary key,
    nama_barang character(50)
);

insert into barang(id_barang, nama_barang) values (1, 'Mouse');
insert into barang(id_barang, nama_barang) values (2, 'Laptop');
select * from barang;

alter table barang rename to stuffs;
select * from stuffs;

alter table stuffs ADD COLUMN if NOT EXISTS details text;
insert into stuffs(id_barang, nama_barang, details) values (3, 'Computer', 'Ini barang mahal yaa');
select * from stuffs;

alter table stuffs ADD COLUMN if NOT EXISTS masuk date;
insert into stuffs(id_barang, nama_barang, details, masuk) values (5, 'Handphone', 'mahal lumayan', '2020-10-10');
select * from stuffs;

alter table stuffs ADD COLUMN if NOT EXISTS price numeric;
select * from stuffs;
alter table stuffs DROP price;
select * from stuffs;

alter table stuffs add COLUMN IF NOT EXISTS pricing money;
insert into stuffs(id_barang, nama_barang, details,masuk,pricing)
values (7, 'Handphone', 'mahal lumayan','2020-10-10', 200000000000);
select * from stuffs;

CREATE TABLE student(
    id_student integer primary key,
    name character(50)
);

-- enumeration
create type gender as ENUM ('MALE','FEMALE','BENCONG','TOMBOY');
create type hari as ENUM ('senin','selasa');
alter table student add column jenis_kelamin gender;

alter table student add column hari_kuliah hari;
insert into student(id_student, name, jenis_kelamin, hari_kuliah)
values (3,'Aditya', 'FEMALE', 'senin');
select * from student;
drop table student;



create type stuff_type as ENUM ('hp','laptop','mouse');
create table barang(
    id_barang integer primary key,
    nama_barang character(30),
    harga_barang money,
    tanggal_masuk date,
    rating_barang smallint,
    tipe_barang stuff_type,
    luas_barang point
);

insert into barang(id_barang, nama_barang,harga_barang,tanggal_masuk,rating_barang,tipe_barang,luas_barang)
values(1,'Mouse', 2000000, '2020-10-10',5,'mouse','(2,3)');

select * from barang;


alter table barang add column line_barang line;
insert into barang(id_barang, nama_barang,harga_barang,tanggal_masuk,rating_barang,tipe_barang,luas_barang, line_barang)
select * from barang;


alter table barang add column polygon_barang polygon;
insert into barang(id_barang, nama_barang,harga_barang,tanggal_masuk,rating_barang,tipe_barang,luas_barang, line_barang, polygon_barang)
values(11,'Mouse', 2000000, '2020-10-10',5,'mouse','(2,3)', '(2,3)(1,2)', '(1,2),(2,3),(3,4),(4,5)');
select * from barang;


alter table barang add column circle_barang circle;
insert into barang(id_barang, nama_barang,harga_barang,tanggal_masuk,rating_barang,tipe_barang,luas_barang, line_barang, circle_barang)
values(13,'Mouse', 2000000, '2020-10-10',5,'mouse','(2,3)', '(2,3)(1,2)','((2,3)6)');
select * from barang;

drop table barang;

create table json_sample(
     id_barang integer primary key,
     json_barang json
);

insert into json_sample(id_barang, json_barang)
values (1, '{
  "name": "Sammidev",
  "kelas": "A",
  "prodi": "Sistem Informasi"
}');

select * from json_sample;

alter table json_sample add column jsonAddress json;
insert into json_sample(id_barang, jsonAddress)
values(2, '{
  "address" : {
    "one": "ONE",
    "two": "TWO",
    "three": "THREE"
  }
}');

select * from json_sample;




create database db_learn;
drop database db_learn;

create table barang(
    id_barang integer primary key,
    nama_barang character(50),
    harga_barang money
);

insert into barang(id_barang,nama_barang,harga_barang) values (1,'oppo find x', 200);
update barang set harga_barang = 20000 where id_barang = 1;
create table pemesanan(
    id_pemesanan integer primary key,
    total_pemesanan integer,
    id_barang integer references barang(id_barang)
);

insert into pemesanan(id_pemesanan, total_pemesanan, id_barang) VALUES (1,200,1);
select  * from pemesanan;
drop table pemesanan;


create table pemesanan(
    id_pemesanan integer primary key,
    nama_pemesan character(40)
);

create table details_pemesanan(
    id_pemesanan integer references pemesanan(id_pemesanan),
    id_barang integer references barang(id_barang),
    total_pemesanan integer,
    primary key(id_pemesanan, id_barang)
);

insert into barang(id_barang,nama_barang,harga_barang) values (2,'samsung s10 ultra', 300);
insert into pemesanan(id_pemesanan, nama_pemesan) VALUES (1,'Sammidev');
insert into details_pemesanan(id_pemesanan, id_barang, total_pemesanan) VALUES (1,2,100);
select * from details_pemesanan;
drop table details_pemesanan;
create table details_pemesanan(
    id_pemesanan integer references pemesanan(id_pemesanan) on delete cascade ,
    id_barang integer references barang(id_barang) on delete restrict,
    total_pemesanan integer,
    primary key(id_pemesanan, id_barang)
);

-- restrict
-- on delete restrict = stock barang terakhir tidak bisa habis ketika pemesanan telah terjadi
-- on delete cascade  = hapus satu relasi

insert into details_pemesanan(id_pemesanan, id_barang, total_pemesanan) VALUES (1,2,230);

delete from barang WHERE id_barang = 2;
-- ON DELETE RESTRICT =  maka akan gagal karena telah dipesan oleh detals pemesanan
select * from details_pemesanan;



insert into barang(id_barang, nama_barang) VALUES (3,'Laptop');
insert into pemesanan(id_pemesanan, nama_pemesan) VALUES (3,'Aditya andika putra');
insert into details_pemesanan(id_pemesanan, id_barang, total_pemesanan) VALUES (3,3,100);
select * from details_pemesanan;
-- ON DELETE CASCADE =  dihapus details itu
delete from pemesanan WHERE id_pemesanan = 3;
select * from details_pemesanan;




create table tb_cashier(
    id_cashier integer primary key,
    name character(20),
    age smallint,
    address text,
    salary money
);

insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(1,'Sammidev1',19,'Lapau Durian, Tinggam',5000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(2,'Sammidev2',20,'Lapau Durian, Tinggam',1000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(3,'Sammidev3',21,'Lapau Durian, Tinggam',2000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(4,'Sammidev4',13,'Lapau Durian, Tinggam',3000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(5,'Sammidev5',19,'Lapau Durian, Tinggam',4000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(6,'Sammidev6',19,'Lapau Durian, Tinggam',5000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(7,'Sammidev7',15,'Lapau Durian, Tinggam',6000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(8,'Sammidev8',19,'Lapau Durian, Tinggam',7000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(9,'Sammidev9',19,'Lapau Durian, Tinggam',8000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(10,'Sammidev10',19,'Lapau Durian, Tinggam',10000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(11,'Sammidev11',19,'Lapau Durian, Tinggam',12000000000);
insert into tb_cashier(id_cashier, name, age, address, salary) VALUES(12,'Sammidev12',19,'Lapau Durian, Tinggam',32000000000);

select  * from tb_cashier;

select name, age from tb_cashier where age = 19;
select * from tb_cashier where age > 15;
select * from tb_cashier where age >= 15;
select name, age from tb_cashier where age < 15;
select name, age from tb_cashier where age <= 15;

-- tidak sama dengan
select name, age from tb_cashier where name != 'Sammidev2';
select name, age from tb_cashier where name <> 'Sammidev2';

-- order by asc desc
select name,salary from tb_cashier order by salary;
select name,salary from tb_cashier order by salary desc;


-- check constraint
create table customer(
    customer_id integer primary key,
    customer_name character(50),
    month_payment numeric check (month_payment > 1),
    discount numeric check (discount > 1),
    check ( month_payment > discount )
);

-- failed
insert into customer (customer_id, customer_name, month_payment, discount)
values (1,'Sammidev', 10, 120);
-- success
insert into customer (customer_id, customer_name, month_payment, discount)
values (2,'Dandi', 10, 2);

select * from customer;


-- OPERATOR

create table arimatika (
    id integer primary key,
    result real
);

insert into arimatika values (1,10%2);
insert into arimatika values (2,10+2);
insert into arimatika values (3,10-2);
insert into arimatika values (4,10*2);
insert into arimatika values (8,|/25);
insert into arimatika values (5,10/2);
insert into arimatika values (6,10^2);
insert into arimatika values (7,10!);

select * from arimatika;
select * from tb_cashier where age > 19 AND salary < '2000000000';
select * from tb_cashier where age > 19 OR salary < '2000000000';
select * from tb_cashier where name like 'S%';
select * from tb_cashier where name like '%v';
select * from tb_cashier where name like '%e%';
select * from tb_cashier where name like '_ammidev%';
select * from tb_cashier where name like 'S_%_%_%_%_%_%_%_';
select * from tb_cashier where age in (19,20,34);
select * from tb_cashier where age between 19 and 100;
select * from tb_cashier limit 5;
select * from tb_cashier limit 2;
select * from tb_cashier limit 4 offset 2;



drop table student;
create table student (
    student_id integer primary key,
    student_name character(50),
    nim character(10) unique,
    created_at date
);


insert into student(student_id, student_name, nim, created_at) values(8,'Sammi Aldhi Yanto','2003113941', '2020-10-10');
insert into student(student_id, student_name, nim, created_at) values(2,'Aditya Andika Putra','2003113942', '2020-10-10');
insert into student(student_id, student_name, nim, created_at) values(3,'Dandi Arnanda','2003113943', '2020-10-10');
insert into student(student_id, student_name, nim, created_at) values(4,'Gusnur','2003113944', '2020-10-10');
insert into student(student_id, student_name, nim, created_at) values(5,'Ayatullah Ramadhan Jacoeb','2003113945', '2020-10-10');
insert into student(student_id, student_name, nim, created_at) values(6,'Abdul Rauf','2003113946', '2020-10-10');
insert into student(student_id, student_name, nim, created_at) values(7,'Aditya Fauzan Nul Haq','2003113947', '2020-10-10');

select * from student;
explain select * from student where nim = '2003113928';

-- make index
create index idx_nim on student(nim);
explain select * from student where nim = '2003113928';

-- make a view
create view view_student as select student_name,nim from student;
select * from view_student;

-- union
create table status(
    id_status integer primary key,
    status text
);

insert into status (id_status, status) values (1, 'ONLINE');
insert into status (id_status, status) values (2, 'LAST SEEN');

alter table student add column id_status integer references status(id_status);
select * from student;


insert into student(student_id, student_name, nim, created_at,id_status) values(10,'Otong Surotong','2003113989', '2020-10-10',1);
select * from student;
update student SET id_status = '1' where nim = '2003113941';
select * from student;

update student SET id_status = '2' where student_id < '8' AND student_id > '0';
select * from student;


select p.student_name, s.status
from student as p
left outer join status as s
on p.id_status = s.id_status

union all

select p.student_name, s.status
from student as p
right outer join status as s
on p.id_status = s.id_status;


select p.student_name, s.status
from student as p
left outer join status as s
on p.id_status = s.id_status

union

select p.student_name, s.status
from student as p
right outer join status as s
on p.id_status = s.id_status;



alter table student add column age smallint;
update student SET age = '19' where student_id > '0';

select * from student;

--  sub query select
select student_name, student.age from student
where age in (select age from student where student.age > '15');

drop table dosen_pembimbing;
create table dosen_pembimbing (
    lecture_id integer primary key,
    lecture_name character(30),
    nip character(10) unique ,
    created_at date,
    id_status integer,
    age integer
);

--  sub query insert
insert into dosen_pembimbing select * from student
where nim in (select nim from student where student_id > '3');

select * from dosen_pembimbing;

--  sub query update
update student set student_id = student_id * 5 where student_id in (select student_id from student where student_id > '5');
select * from student;

--  sub query delete
update student set  age = 14 where student_id = '2';
delete from student where student.age in (select student.age where student.age < '19');
select * from student;


-- create array
create table tb_data_student (
    id_student integer primary key,
    nama text,
    age smallint[],
    nim smallint[][]
);

select * from tb_data_student;

insert into tb_data_student values (1,'Sammidev','{12,19,20}', '{{12},{13}}');
insert into tb_data_student values (2,'Aditya','{13,14,25}', '{{14},{11}}');
insert into tb_data_student values (3,'Aditya','{13,14,25}', '{{14},{11}}');
select * from tb_data_student;

select nama,age[1] from tb_data_student;
select nama,age[2] from tb_data_student;
select nama,age from tb_data_student where age[1] = age[2];
alter table tb_data_student add column kelas integer[][];
select array_dims(age) from tb_data_student;
select array_dims(kelas) from tb_data_student;

select * from tb_data_student;
update tb_data_student SET age = '{1,1,1}' where nama = 'Aditya';
select * from tb_data_student;

update tb_data_student SET age [2] = '1000' where nama = 'Aditya';
select * from tb_data_student;

update tb_data_student set age = array_append(age,'12');
select * from tb_data_student;

update tb_data_student set age = array_remove(age, '1');
select * from tb_data_student;

select * from tb_data_student where age[1] = '12' or age[2] = '2';

