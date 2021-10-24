Task 1: \
[docker-compose файл](hw6/docker-compose.yml)

Task 2:
```
create database "test-db";

create user "test-admin-user" with encrypted password '12345';
grant all privileges on database "test-db" to "test-admin-user";

create user "test-simple-user" with encrypted password '12345';
grant connect on database "test-db" to "test-simple-user";

-- логинимся за test-admin-user
grant usage on schema public TO "test-simple-user";
grant select, insert, update, delete on all tables in schema public to "test-simple-user";
grant all privileges on all sequences in schema public to "test-simple-user";

create sequence order_seq;

create table orders (
    id int primary key,
    name varchar(100),
    price int
);

create sequence clients_seq;

create table clients (
  id int primary key,
  second_name varchar(50),
  country varchar(100),
  order_id int
);

alter table clients add constraint clients_order_fk foreign key (order_id) references orders (id);
```
Список баз данных:
```
SELECT datname FROM pg_database
WHERE datistemplate = false;
-- результат
datname
test-db
postgres
```
Описание таблиц:
```
select table_name, column_name, column_default, data_type
from information_schema.COLUMNS
where table_schema = 'public';

-- результат
table_name column_name	column_default  data_type
orders	   name		                character varying
clients	   second_name		        character varying
clients	   country		        character varying
clients	   id		                integer
clients	   order_id		        integer
orders	   id		                integer
orders	   price		        integer
```
Пользователи и права
```
SELECT grantee, privilege_type
FROM information_schema.role_table_grants
-- результат
test-admin-user	        REFERENCES  public	orders
test-admin-user	        TRIGGER	    public	orders
test-admin-user	        INSERT	    public	clients
test-admin-user	        SELECT	    public	clients
test-admin-user	        UPDATE	    public	clients
test-admin-user	        DELETE	    public	clients
test-admin-user	        TRUNCATE    public	clients
test-admin-user	        REFERENCES  public	clients
test-admin-user	        TRIGGER	    public	clients
test-simple-user	INSERT	    public	orders
test-simple-user	SELECT	    public	orders
test-simple-user	UPDATE	    public	orders
test-simple-user	DELETE	    public	orders
test-simple-user	INSERT	    public	clients
test-simple-user	SELECT	    public	clients
test-simple-user	UPDATE	    public	clients
test-simple-user	DELETE	    public	clients
```

Task 3:
```
insert into orders (id, name, price)
select
    nextval('order_seq') as id,
    'Шоколад' as name,
    10 as price
union
select
    nextval('order_seq') as id,
    'Принтер' as name,
    3000 as price
union
select
    nextval('order_seq') as id,
    'Книга' as name,
    500 as price
union
select
    nextval('order_seq') as id,
    'Монитор' as name,
    7000 as price
union
select
    nextval('order_seq') as id,
    'Гитара' as name,
    4000 as price;
commit;
```
```
insert into clients (id, second_name, country) 
select
       nextval('clients_seq') as id,
       'Иванов Иван Иванович' as second_name,
       'USA' as country
union
select
       nextval('clients_seq') as id,
       'Петров Петр Петрович' as second_name,
       'Canada' as country
union
select
       nextval('clients_seq') as id,
       'Иоганн Себастьян Бах' as second_name,
       'Japan' as country
union
select
       nextval('clients_seq') as id,
       'Ронни Джеймс Дио' as second_name,
       'Russia' as country
union
select
       nextval('clients_seq') as id,
       'Ritchie Blackmore' as second_name,
       'Russia' as country;
commit;
```
```
select count(*) from orders;
-- результат
5
```
```
select count(*) from clients;
-- результат
5
```

Task 4:
```
update clients
set order_id = o.id
from orders as o
where o.name = 'Книга' and clients.second_name = 'Иванов Иван Иванович';
commit;

update clients
set order_id = o.id
from orders as o
where o.name = 'Монитор' and clients.second_name = 'Петров Петр Петрович';
commit;

update clients
set order_id = o.id
from orders as o
where o.name = 'Гитара' and clients.second_name = 'Иоганн Себастьян Бах';
commit;
```
Запрос: пользователи совершившие заказ
```
select second_name from clients as c where c.order_id is not null;
--результат
Иванов Иван Иванович
Петров Петр Петрович
Иоганн Себастьян Бах
```

Task 5:
```
explain analyse
select * from clients as c where c.order_id is not null;
--результат 
Seq Scan on clients c  (cost=0.00..12.10 rows=209 width=344) (actual time=0.019..0.066 rows=3 loops=1) <-- оператор поиска Sequential Scan
  Filter: (order_id IS NOT NULL)                                                                       <-- условие фильтрации выборки
  Rows Removed by Filter: 2                                                                            <-- число отфильтрованных строк     
Planning Time: 0.056 ms
Execution Time: 0.234 ms

cost -- какие-то собственные попугаи оптимизатора, чем меньше значение тем лучше.
rows -- должно быть число строк на базе которых строился анализ, число явно некорректное, мб анализтор нагенерил 209 фантомных строк...
самым важным является параметр Execution Time -- показывает время выполнения запроса на выборке которая используется для analyze.
```

Task 6:
```
su postgres
pg_dump -v -O -C test-db > /postgresql-backup/test_db_dump.sql

pg_dump: last built-in OID is 16383
pg_dump: reading extensions
pg_dump: identifying extension members
pg_dump: reading schemas
pg_dump: reading user-defined tables
pg_dump: reading user-defined functions
pg_dump: reading user-defined types
pg_dump: reading procedural languages
pg_dump: reading user-defined aggregate functions
pg_dump: reading user-defined operators
pg_dump: reading user-defined access methods
pg_dump: reading user-defined operator classes
pg_dump: reading user-defined operator families
pg_dump: reading user-defined text search parsers
pg_dump: reading user-defined text search templates
pg_dump: reading user-defined text search dictionaries
pg_dump: reading user-defined text search configurations
pg_dump: reading user-defined foreign-data wrappers
pg_dump: reading user-defined foreign servers
pg_dump: reading default privileges
pg_dump: reading user-defined collations
pg_dump: reading user-defined conversions
pg_dump: reading type casts
pg_dump: reading transforms
pg_dump: reading table inheritance information
pg_dump: reading event triggers
pg_dump: finding extension tables
pg_dump: finding inheritance relationships
pg_dump: reading column info for interesting tables
pg_dump: finding the columns and types of table "public.orders"
pg_dump: finding the columns and types of table "public.clients"
pg_dump: flagging inherited columns in subtables
pg_dump: reading indexes
pg_dump: reading indexes for table "public.orders"
pg_dump: reading indexes for table "public.clients"
pg_dump: flagging indexes in partitioned tables
pg_dump: reading extended statistics
pg_dump: reading constraints
pg_dump: reading foreign key constraints for table "public.orders"
pg_dump: reading foreign key constraints for table "public.clients"
pg_dump: reading triggers
pg_dump: reading triggers for table "public.orders"
pg_dump: reading triggers for table "public.clients"
pg_dump: reading rewrite rules
pg_dump: reading policies
pg_dump: reading row security enabled for table "public.order_seq"
pg_dump: reading policies for table "public.order_seq"
pg_dump: reading row security enabled for table "public.orders"
pg_dump: reading policies for table "public.orders"
pg_dump: reading row security enabled for table "public.clients_seq"
pg_dump: reading policies for table "public.clients_seq"
pg_dump: reading row security enabled for table "public.clients"
pg_dump: reading policies for table "public.clients"
pg_dump: reading publications
pg_dump: reading publication membership
pg_dump: reading subscriptions
pg_dump: reading large objects
pg_dump: reading dependency data
pg_dump: saving encoding = UTF8
pg_dump: saving standard_conforming_strings = on
pg_dump: saving search_path =
pg_dump: saving database definition
pg_dump: creating DATABASE "test-db"
pg_dump: connecting to new database "test-db"
pg_dump: creating TABLE "public.clients"
pg_dump: creating SEQUENCE "public.clients_seq"
pg_dump: creating SEQUENCE "public.order_seq"
pg_dump: creating TABLE "public.orders"
pg_dump: processing data for table "public.clients"
pg_dump: dumping contents of table "public.clients"
pg_dump: processing data for table "public.orders"
pg_dump: dumping contents of table "public.orders"
pg_dump: executing SEQUENCE SET clients_seq
pg_dump: executing SEQUENCE SET order_seq
pg_dump: creating CONSTRAINT "public.clients clients_pkey"
pg_dump: creating CONSTRAINT "public.orders orders_pkey"
pg_dump: creating FK CONSTRAINT "public.clients clients_order_fk"
pg_dump: creating ACL "DATABASE "test-db""
```
Результат дампа: [текстовый дамп с данными](/hw6/backup/test_db_dump.sql) \
В случае текстового файла бэкапа можно восстановить так
```
su postgres
psql -v -d postgres -f /postgresql-backup/test_db_dump.sql

SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
CREATE DATABASE
You are now connected to database "test-db" as user "postgres".
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
CREATE SEQUENCE
CREATE SEQUENCE
CREATE TABLE
COPY 5
COPY 5
 setval
--------
     10
(1 row)

 setval
--------
      5
(1 row)

ALTER TABLE
ALTER TABLE
ALTER TABLE
GRANT
```
если бэкап бинарный, то надо воспользоваться pg_restore.\
После из скриптов создания пользователей, надо восстановить пользаков (или через pg_dumpall -r и подчистить лишних).
