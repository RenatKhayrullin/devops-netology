Task 1:
1) Push модель:\
   плюсы: \
   упрощение репликции, можно использовать одновременно несколько разных систем мониторинга куда будут отправляться сообщения; \
   гибкая настройка мониторинга и упрощенная возможность фильтрации сообщений; \
   минусы: \
   нет гарантии доставки сообщений; \
   нет гарантии что не пришлют "мусор" или неактуальные данные; \
   хорошая производительность;
2) Pull модель:\
   плюсы: \
   гарантия, что мониторится только то что надо; \
   возможность настройки гарантий безопасности взаимодействия агентов с объектами мониторинга; \
   гарантия получения всех возможных данных; \
   проще отлаживать работу системы; \
   минусы: \
   сложность настройки и фильтрации сообщений мониторинга; \
   дополнительные расходы на реализацию сбора данных на уровне объектов мониторинга;
   
Task 2: 
1) Prometheus -- pull, требуется настройка exporter
2) TICK -- push, т.к. данные пересылаются агентами
3) Zabbix -- push/pull, возможны обе реализации передачи сообщений
4) VictoriaMetrics -- push/pull, возможны обе реализации передачи сообщений
5) Nagios -- push, т.к. данные пересылаются агентами

Task 3:

```
curl http://localhost:8888
<!DOCTYPE html><html><head><meta http-equiv="Content-type" content="text/html; charset=utf-8"><title>Chronograf</title><link rel="icon shortcut" href="/favicon.fa749080.ico"><link rel="stylesheet" href="/src.9cea3e4e.css"></head><body> <div id="react-root" data-basepath=""></div> <script src="/src.a969287c.js"></script> </body></html>
```

/ping ничего не выдает в response (возможно надо использовать /health в ДЗ) 
```
curl -vvv http://localhost:8086/ping

*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8086 (#0)
> GET /ping HTTP/1.1
> Host: localhost:8086
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 204 No Content <-- сильно сбивает с толку.... ответ 2xx а resposnse нет
< Content-Type: application/json
< Request-Id: cc366224-c024-11ec-80d7-0242ac1a0003
< X-Influxdb-Build: OSS
< X-Influxdb-Version: 1.8.10
< X-Request-Id: cc366224-c024-11ec-80d7-0242ac1a0003
< Date: Tue, 19 Apr 2022 21:08:01 GMT
<
* Connection #0 to host localhost left intact
* Closing connection 0
```

```
curl http://localhost:9092/kapacitor/v1/ping

*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 9092 (#0)
> GET /kapacitor/v1/ping HTTP/1.1
> Host: localhost:9092
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 204 No Content <-- сильно сбивает с толку....
< Content-Type: application/json; charset=utf-8
< Request-Id: 05a15bb9-c026-11ec-8169-000000000000
< X-Kapacitor-Version: 1.6.4
< Date: Tue, 19 Apr 2022 21:16:47 GMT
<
* Connection #0 to host localhost left intact
* Closing connection 0
```

P.S. про настройку telegraf тоже стоит указать в ДЗ, т.к. они перекроили базовый образ и контейнер запускается из под пользователя telegraf.