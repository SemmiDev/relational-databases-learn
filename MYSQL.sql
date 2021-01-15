-- CREATE DATABASE IF NOT EXISTS students;
-- SHOW DATABASES;
-- USE students;

-- CREATE TABLE student (
--     student_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
--     first_name VARCHAR (50) NOT NULL,
--     last_name VARCHAR (50) NOT NULL,
--     nim CHAR(7) NOT NULL UNIQUE,
--     class CHAR(7) NOT NULL,
--     major VARCHAR(50) NOT NULL,
--     faculty CHAR(7) NOT NULL,
--     unversity CHAR(7) NOT NULL,
--     email CHAR(7) NOT NULL UNIQUE,
--     phoneNumber VARCHAR(20) NOT NULL UNIQUE ,
--     hobbies VARCHAR(250),
--     address_id INT UNSIGNED NOT NULL UNIQUE ,
--     last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     PRIMARY KEY (student_id),
--     KEY idx_student_last_name (last_name),
--     KEY idx_student_address_id (address_id),
--     CONSTRAINT `fk_student_address` FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE address (
--     address_id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE ,
--     address VARCHAR(50) NOT NULL,
--     address2 VARCHAR(50) DEFAULT NULL,
--     district VARCHAR(10) NOT NULL,
--     city_id INT UNSIGNED NOT NULL,
--     postal_code VARCHAR(10) DEFAULT NULL,
--     last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     PRIMARY KEY (address_id),
--     KEY idx_fk_city_id (city_id),
--     CONSTRAINT `fk_address_city` FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE RESTRICT ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- # fk = foreign key
-- # on delete cascase = jika ctt induk dihapus, ctt anak juga akan dihapus
-- # on update cascase = jika ctt induk diubah, maka anak diubah juga
-- # on delete cascase on update cascase = keduanya
-- # restrict mnddkan bahwasetiap upaya untuk menghapus / memperbarui induk akan gagal

-- CREATE TABLE city (
--     city_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
--     city VARCHAR(50) NOT NULL,
--     country_id SMALLINT UNSIGNED NOT NULL,
--     last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     PRIMARY KEY  (city_id),
--     KEY idx_fk_country_id (country_id),
--     CONSTRAINT `fk_city_country` FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE RESTRICT ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE country (
--     country_id INT NOT NULL AUTO_INCREMENT,
--     country VARCHAR(50) NOT NULL,
--     last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     PRIMARY KEY(country_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


show databases;
drop DATABASE belajar_mysql;
create database belajar_mysql;
drop database belajar_mysql;
create database belajar_mysql;
use belajar_mysql;
show tables;
-- DATE = 2020-12-12
-- DATETIME = 2020-12-12 10:10:10
-- TIMESTAMP = 2020-12-12 10:10:10 (ex: created_at)
-- TIME = 12:10:10
-- YEAR = 2020

show engines;
create table barang (
    kode INT,
    nama varchar(100),
    harga INT,
    jumlah INT
) engine = InnoDB;

desc barang;
show create table barang; -- with syntax

alter table barang
    add column age int after nama;

alter table barang
    drop column age;

alter table barang
    add column age int,
    modify age bigint after harga;


alter table barang
    modify kode varchar(20) not null,
    modify nama varchar(20) not null,
    modify harga decimal(5,2) not null,
    drop column age;

alter table barang
    modify jumlah int unsigned;

alter table barang
    add column created_at timestamp default current_timestamp();
alter table barang
    modify harga decimal(5,2) not null default 0.00;

create table tb_temp_student(
    id int auto_increment primary key,
    name varchar(255) not null,
    nim varchar(10) not null unique,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

insert into tb_temp_student(name,nim,created_at)
value ('sammidev','2003113948', now());

select * from tb_temp_student;

# hapus isi dan recreate table
truncate tb_temp_student;
# hapus table barang
drop table tb_temp_student;


create table product (
    id int primary key auto_increment,
    name varchar(100) not null,
    description text default '',
    price decimal(7,2) unsigned not null default 0.0,
    quantity int unsigned not null default 0,
    created_at timestamp not null default current_timestamp
);

desc product;

insert into product(name, description, price, quantity, created_at)
VALUE  ('mouse','nothing',90000.00, 10, now());

select  * from product;

alter table product
    add column product_code varchar(50) not null unique;


insert into product(name, description, price, quantity, created_at, product_code)
VALUE  ('mouse','nothing', 90000.00, 10, now(), 'm6'),
       ('mouse2','nothing',13000.00, 10, now(),'m7'),
       ('mouse3','nothing',20000.00, 10, now(),'m8'),
       ('mouse4','nothing',30000.00, 10, now(),'m9'),
       ('mouse5','nothing',40000.00, 10, now(),'m10');

select name,price,product_code from product;


# where clause
select name,price from product where id = 1;
select name,price,quantity from product where product.product_code = 'm3';


select name,price from product where id < 2;
select name,price from product where id <= 2;

alter table product
    add column category enum ('Food','Drink')
    after quantity;
desc product;

alter table product
modify column category enum ('NONE','Food','Drink') default 'NONE';

update product
set belajar_mysql.product.category = 'Food' where id = '4';

select category from product where id='4';

update product set
    belajar_mysql.product.category = 'Drink',
    belajar_mysql.product.name = 'grape juice',
    belajar_mysql.product.quantity = '20'
where id = 5;

select category,name,quantity from product where id = '5';


update product set quantity = quantity + 1000
where id = '1';

select quantity from product;


delete from product where id = '2';
select * from product where id = '2';

select name as 'nama produk', price as 'harga produk' from product;

#  alias di table
select
       p.name as 'NAMA',
       p.quantity as 'JUMLAH',
       p.price as 'HARGA'
from product as p;

select name from product where id = 10;
select name from product where id > 10;
select name from product where id < 10;
select name from product where id <> 10;
select name from product where id != 10;



select name,price from product where name = 'mouse2' and price = '13000.00';
select name,price from product where name = 'mouse212321' or price = '13000.00';

update product set name = 'sammidev' where name = 'mouse2' and price = '13000.00';
select name,price from  product where name='sammidev';

select name,price from product where (name = 'sammidev' and price = '13000.00') or quantity=2;

select name,price from product where name not like  'sammidev';
select name,price from product where name like 'sam%';
select name,price from product where name like '%dev';
select name,price from product where name like 'sa%dev';

select name from product where product.category is null ;
select name from product where product.category is not null ;

select * from product where id between 1 and 5;

# in == or
select name from  product where name in ('mouse','mouse2');
select name from  product where name not in ('mouse','mouse2');

select name from belajar_mysql.product order by id desc;

select name,price from product where id > 5 order by id desc limit 2;


select  * from product where id > 0 order by price desc  limit 2, 2;

select distinct description from product;

select  10 + 12 as hasil;

select id ,name, price, price div 10 as 'price in k' from product;

select PI();
select POWER(2,10);
select COS(45);
select SIN(45);
select TAN(45);


select id, cos(price), tan(price), sin(price) from product;

select id,name,price, price div 1000 from product where price div 1000 > 40;


create table admin(
    id int auto_increment,
    username varchar(100) not null unique,
    password varchar(100) not null unique,
    primary key (id)
);

insert into admin(username, password)
values ('sammidev','sammidev'),
       ('sammidev2','sammidev2'),
       ('sammidev3','sammidev3');

select  * from admin;
alter table admin
    modify username varchar(40) not null;

desc admin;

# id terakhir yg di generate
select last_insert_id();

select  id,
       lower(name) as 'Nama Lowe',
       upper(name) as 'Upper Name',
       length(name) as 'Lebar Nama'
from product where length(name) > 6;



select name,product.product_code,
       extract(YEAR  from created_at) as 'YEAR',
       extract(MONTH  from created_at) as 'MONTH'
from product;

# atau

select name,product.product_code,
       year(created_at), month(created_at) from product;

explain product;

select id,
       case category
            when 'Food' then 'MMMM'
            when 'Drink' then 'ISS'
            else 'tai'
            end as 'Category'
from product;


select id,price,
       if(price < 2300, 'murah',
           if(price < 4300, 'mahal', 'mahalll'))
           as 'status?'
from  product;

select id,name, ifnull(description, 'ganti dengan text ini')
from product;


select name, count(product.price) from product;
select name, avg(product.price) from product;
select name, max(product.price) from product;
select name, min(product.price) from product;

select SUM(quantity) AS 'AVAILABLE' from product;


select  name, count(id) as 'total product', product.category
from product group by product.category;

select max(price) as 'harga termahal', category from
product group by category;

select max(quantity) as 'stock per category', category
from    product group by category;

select  category,quantity from  product;

select category, count(quantity) as 'qty'
from product group by category having qty < 10;

create table customer
(
    id_customer int auto_increment,
    name        varchar(50) not null,
    email       varchar(50) not null,
    primary key (id_customer),
    constraint unique key email_unique (email)
);
desc customer;

alter table customer
    add constraint name_unique unique (name);
alter table customer
    drop constraint name_unique;


drop table product;

CREATE TABLE product (
    id int auto_increment,
    name varchar(100) not null,
    product_code varchar(100) not null,
    price decimal(8,2) not null,
    quantity int not null,
    create_at timestamp not null default current_timestamp,
    primary key (id),
    constraint qty_check check ( product.quantity > 5 and quantity < 20),
    constraint product_code_unique unique key (product_code)
 );

desc belajar_mysql.product;


insert into belajar_mysql.product(name, product_code, price, quantity, create_at)
values ('laptop', 'aaa', '1000',10,now());


# unique otomatis ada index
# primarukey otomatis ada index
drop table if exists seller;
create TABLE seller (
    id int not null auto_increment,
    name varchar(100) not null ,
    email varchar(100) not null,
    primary key (id),
    unique key email_unique (email),
    index name_index (name)
) engine = InnoDB;

desc seller;
show create table seller;
alter table seller
    drop index name_index;


alter table seller
    add fulltext name_search (name, email);

insert into seller(name, email) values
("sammi", "sammidev@gmail.com"),
("sammi aldhi", "sammidev2@gmail.com"),
("sammi yanto", "sammidev3@gmail.com"),
("sammi aldhi yanto", "sammidev4@gmail.com"),
("aldhi yanto", "sammide5v@gmail.com");

select  * from seller;

select *
from seller where MATCH(name)
AGAINST('sam', IN NATURAL BOOLEAN MODE);











drop table product;
create table product(
    ID INT primary key auto_increment,
    name varchar(100) not null,
    price decimal not null,
    product_code varchar(10) not null unique
) engine = InnoDB;

CREATE TABLE wishlist(
    id int primary key auto_increment,
    id_product int not null,
    description text,
    constraint fk_wishlist_prduct foreign key (id_product) references product(id)
) engine = innoDB;

desc wishlist;

insert into product(name, price, product_code )
values
('asadasd', '2312123', 'asdas2'),
('asadasd', '2312123', 'asdas3'),
('asadasd', '2312123', 'asdas4'),
('asadasd', '2312123', 'asdas5'),
('asadasd', '2312123', 'asda6s'),
('asadasd', '2312123', 'as4das'),
('asadasd', '2312123', 'asndas'),
('asadasd', '2312123', 'asvdas');

select * from product;

insert into wishlist( id_product, description) values
(2,'asdasd'),
(2,'asdasd'),
(1,'asdasd'),
(5,'asdasd');

select * from wishlist;

alter table wishlist
    drop constraint fk_wishlist_prduct;

alter table wishlist
    add constraint fk_wishlist_prduct foreign key (id_product) references product(id)
        on delete cascade on update cascade;


desc wishlist;


update product set id = 10 where id = 2;
delete from product  where id = 10;
select *
from wishlist;












drop table wishlist;
drop table product;
drop table customer;

create table product(
    id int auto_increment,
    product_code varchar(100) not null,
    name varchar(100) not null,
    price decimal(10,2) not null,
    quantity int not null check ( quantity > 1 ),
    description text,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    primary key (id),
    constraint unique product_code_unique(product_code),
    index product_name (name)
) engine = InnoDB;

create table customer(
    id int auto_increment,
    name varchar(100) not null,
    email varchar(100) not null,
    phone varchar(14) not null check ( length(phone) = 14 ),
    primary key (id) ,
    constraint unique email_unique(email),
    index customer_name (name)
) engine = InnoDB;

CREATE TABLE wishlist(
    id int primary key auto_increment,
    id_customer int not null,
    id_product int not null,
    description text,
    constraint fk_wishlist_product foreign key (id_product) references product(id) on delete cascade on update cascade,
    constraint fk_wishlist_customer foreign key (id_customer) references customer(id) on delete cascade on update cascade
) engine = innoDB;

desc product;
desc customer;
desc wishlist;

insert into product(product_code, name, price, quantity, description) VALUES
('m1','mousea','200000','5','nothing'),
('m2','mouseb','200000','5','nothing'),
('m3','mousec','200000','5','nothing'),
('m4','moused','200000','5','nothing'),
('m','mousee','200000','5','nothing'),
('m6','mousef','200000','5','nothing');

insert into customer (name,email,phone)values
('sam', 'sammidev1@gmail.com', '00000000008888'),
('sam','sammidev2@gmail.com', '00000000018888'),
('sam','sammidev3@gmail.com', '00000000028888'),
('sam','sammidev4@gmail.com', '00000000038888'),
('sam','sammidev5@gmail.com', '00000000048888'),
('sam','sammidev6@gmail.com', '00000000058888');


insert into wishlist(id_customer ,id_product, description) values
('1','1','descccc'),
('2','1','descccc'),
('3','2','descccc'),
('3','2','descccc'),
('4','2','descccc'),
('1','3','descccc'),
('3','3','descccc');


insert into wishlist(id_customer,id_product, description)
values
('1','1','description'),
('2','1','description'),
('3','2','description'),
('4','4','description'),
('5','4','description');


select * from wishlist;

select customer.email, product.id, product.name from wishlist
join product on (product.id = wishlist.id_product)
join customer on (customer.id = wishlist.id_customer);

# JOIN
select * from customer join product on (customer.product_id = product.id);
select c.id, c.name, p.id ,p.name from customer as c join product  as p on (c.product_id = p.id);
select c.id as 'CUSTOMER ID', c.name as 'CUSTOMER NAME', p.id as 'PRODUCT ID' ,p.name as 'PRODUCT NAME' from customer as c join product  as p on (c.product_id = p.id);


# # one to one -> 1 customer 1 wallet
#
# drop table wishlist;
# drop table product;
# drop table customer;
#
# create table customer(
#     id int auto_increment,
#     email varchar(100) not null,
#     firstname varchar(100) not null,
#     lastname varchar(100),
#     constraint unique email_unique(email),
#     primary key (id)
# ) engine = InnoDB;
#
# create table wallet(
#       id int not null auto_increment,
#       customer_id int not null,
#       balance decimal not null default 0,
#       primary key(id),
#       unique key customer_id_unique(customer_id),
#       constraint fk_customer_id
#           foreign key (customer_id) references customer(id) on delete cascade on update cascade
#
# );
#
# desc wallet;
#
# insert into customer(email, firstname, lastname) values
# ('sammidev1@gmmail.com', 'sammi1','dev1'),
# ('sammidev2@gmmail.com', 'sammi2','dev2'),
# ('sammidev3@gmmail.com', 'sammi3','dev3');
#
# insert into wallet(customer_id, balance) values
# ('1', '0'),
# ('2', '0'),
# ('3', '0');
#
# select * from customer;
# select * from wallet;
#
#
# # one to many -> 1 category bisa diunakan banyak product
# create table product(
#     id int auto_increment,
#     name varchar(100) not null,
#     price decimal not null default 0,
#     quantity int unsigned not null default 1,
#     primary key (id)
# ) engine = InnoDB;
#
# create table category(
#     id int auto_increment,
#     name varchar(100) not null,
#     description varchar(100) default null,
#     primary key (id)
# ) engine = InnoDB;
#
# alter table product
#     add column category_id int not null after id;
# alter table product
#     add constraint fk_category_id foreign key (category_id) references category(id);
# desc product;
#
# insert into category(name, description) values
# ('Makanan', 'ini makanan'),
# ('Minuman', 'ini Minuman'),
# ('Lain-Lain', 'ini lain-lain');
#
# insert into product(name,category_id, price, quantity) values
# ('Pizza','1','400000', 10),
# ('Pizza2','1','400000', 10),
# ('alkohol','2','400000', 10),
# ('alkohol','2','400000', 10),
# ('permen','3','400000', 10);
#
# select * from product;
# select * from category;
#
#
# select product.id as 'PRODUCT ID', product.name as 'PRODUCT NAME', category.name as 'PRODUCT CATEGORY' from product
# join category on (category.id = product.category_id );



# many to many
show tables in  belajar_mysql;
drop table belajar_mysql.product;

create table belajar_mysql.product(
    id int primary key auto_increment,
    name varchar(100) not null,
    price decimal not null default 0,
    quantity int unsigned not null default 0
);

create table belajar_mysql.order(
    id int primary key auto_increment,
    total int not null,
    create_order timestamp default current_timestamp
);

create table belajar_mysql.order_detail(
    id_product int not null,
    id_order int not null,
    quantity int unsigned,
    price decimal not null,
    primary key (id_product, id_order)
);

alter table order_detail
add constraint fk_order_details_product
foreign key (id_product) references belajar_mysql.product(id);

alter table order_detail
add constraint fk_order_details_order
foreign key (id_order) references belajar_mysql.order(id);

desc order_detail;
show create table order_detail;

# 4:54
