Task 1:

1. вывод списка БД ```\l```
2. подключениe к БД ```\c <database_name>```
3. вывода списка таблиц ```\d``` 
4. вывода описания содержимого таблиц ```\d+ <table_name>```
5. выхода из psql ```\q```

Task 2:
```
su postgres
psql
create database test_database;
\q
psql -d test_database -f postgresql-backup/dump.sql
```
```
psql
\c test_database
\d
analyze orders;
select attname, max(avg_width) from pg_stats
where schemaname = 'public' and tablename = 'orders'
group by attname
order by 2 desc;

--результат

 attname | max
---------+-----
 title   |  16
 id      |   4
 price   |   4
```

Task 3:
```
create table new_orders (
   id integer primary key,
   title varchar(80),
   price integer
);
create table orders_1 (
   constraint orders_1_pk primary key (id),
   constraint check_price_1 check (price > 499)
) inherits (new_orders);
create table orders_2 (
   constraint orders_2_pk primary key (id),
   constraint check_price_2 check (price <= 499)
) inherits (new_orders);

insert into orders_1 (id, title, price)
select id, title, price
from orders
where price > 499;
commit;

insert into orders_2 (id, title, price)
select id, title, price
from orders
where price <= 499;
commit;

drop table orders;
alter table new_orders rename to orders;
```
Можно создавать партиции после создания таблицы и перед вставкой данных.
```
create table new_orders (
   id integer not null,
   title varchar(80),
   price integer,
   constraint pk primary key (id, price)
) partition by range(price);

create table order_1 partition of orders
for values from (minvalue) to 499

create table order_2 partition of orders
for values from 499 to (maxvalue)
```

Task 4: \

Бэкапим схему данных:
```
su postgres
pg_dump -O -C -s test_database > /postgresql-backup/test_db_schema_dump.sql ('-s' flag -- только схема без данных)
```
Бэкапим данные:
```
pg_dump -O -a test_database > /postgresql-backup/test_db_data_dump.sql ('-a' flag -- только данныe)
```
Восстанавливаем схему:
```
su postgres
psql -d postgres -f /postgresql-backup/test_db_schema_dump.sql
```
Добавляем ограничение ибо дописываем в конец sql файла с бэкапом схемы:
```
su postgres
\c test_database
ALTER TABLE orders ADD CONSTRAINT orders_title_unq UNIQUE (title);
```

Восстанавливаем данные:
```
su postgres
psql -d test_database -f /postgresql-backup/test_db_dump.sql
```

