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