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
pg_dump -O -C test-db > /postgresql-backup/test_db_dump.sql
```
В случае текстового файла бэкапа можно восстановить так \
Если бэкап бинарный, то воспользоваться pg_restore.
```
su postgres
psql -d postgres -f /postgresql-backup/test_db_dump.sql
```