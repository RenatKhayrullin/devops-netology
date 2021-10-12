Task 1: \
Сценарий:

1. Высоконагруженное монолитное java веб-приложение; \
docker, т.к. удобно масштабировать, перезапускать, настраивать квоты и параметризацию, можно быстро поднять несколько контейнеров из одного образа
2. Go-микросервис для генерации отчетов; \
docker, т.к. удобно масштабировать, перезапускать, настраивать квоты и параметризацию, можно быстро поднять несколько контейнеров из одного образа 
3. Nodejs веб-приложение; \
docker, т.к. удобно масштабировать, перезапускать, настраивать квоты и параметризацию, можно быстро поднять несколько контейнеров из одного образа 
4. Мобильное приложение c версиями для Android и iOS; \
в docker удобно и легко поднимать тестовые окружения с разными версиями мобильных OS 
5. База данных postgresql используемая, как кэш; \
в данном случае можно поднять и в docker, при условии что не будут распухать данные на диске, либо с сохранением data файлов БД на диске хоста через volume
6. Шина данных на базе Apache Kafka; \
лучше на физ.машине, т.к. kafka стоит реплицировать на несколько нод и все сообщения пишет на диск, хотя эти данные можно вывести в volume на сервере, а в докере поднять только само приложение 
7. Очередь для Logstash на базе Redis; \
аналогично п.6.
8. Elastic stack для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana; \
elasticsearch лучше на физ.машине, остальное удобнее поднять в docker
9. Мониторинг-стек на базе prometheus и grafana; \
можно в docker, с сохранением временных рядов prometheus в volume на диске хоста
10. Mongodb, как основное хранилище данных для java-приложения; \
физ. машина, либо бинарники в docker, а хранилище в volume
11. Jenkins-сервер; \
если подразумевается кластерное масштабирование контейнера сервлетов -- физ.машина, если микросервис на embedded jenkins -- docker

Но в каждом конкретном случае надо отдельно прорабатывать ситуацию с хранением данных, \
т.к. вывод данных в volume не является универсальной методикой разворачивания систем внешних ресурсов.

Task 2: \
Создадим [docker образ](hw3/Dockerfile) взяв за базовый образ ```httpd```.\
Соберем и запушим образ в docker hub.
```
docker build -t devops-netology-apache2 .
docker tag devops-netology-apache2:latest kh4k1/kh4k1_repo
docker push kh4k1/kh4k1_repo:latest
```
Запустим контейнер
```
docker run -dit --name devops-netology-app -p 8080:80 devops-netology-apache2
```
и проверим, что по адресу ```localhost:8080/Index.html``` отображается [страница](hw3/public-html/Index.html).

Task 3:
```
docker run -dit --name centos-test -v "$(pwd)"/info:/share/info centos:latest
docker run -dit --name debian-test -v "$(pwd)"/info:/share/info debian:latest
docker exec -d centos-test touch /share/info/some_msg.txt
docker attach debian-test
root@2612706caa40:/# ls -la /share/info
total 4
drwxr-xr-x 4 root root  128 Oct 12 15:59 .
drwxr-xr-x 3 root root 4096 Oct 12 15:56 ..
-rw-r--r-- 1 root root    0 Oct 12 15:58 some_msg.txt
-rw-r--r-- 1 root root    0 Oct 12 15:59 some_msg_1.txt
root@2612706caa40:/#
```