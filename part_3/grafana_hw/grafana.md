Task 1: \
[docker-compose](docker-compose-monitoring.yml)

Настройки Prometheus: \
[prometheus конфиг](monitoring/prometheus/configuration/prometheus.yml) \
[prometheus алерт](monitoring/prometheus/configuration/alert.yml) \
[prometheus executable](monitoring/prometheus/executables/prometheus_run.sh) 

Настройки Grafana: \
[prometheus конфиг](monitoring/grafana/configuration/config.ini) \
[настройка data source](monitoring/grafana/configuration/provisioning/datasources/all.yml) \
[настройка dashboard](monitoring/grafana/configuration/provisioning/dashboards/all.yml) \
[grafana executable](monitoring/grafana/executables/grafana_run.sh)

Task 3:

Что такое CPULA 1/5/15, я не очень понял без описания.

Монитор диска:
```
node_filesystem_avail_bytes{fstype!~"tmpfs|fuse.lxcfs|squashfs"} / node_filesystem_size_bytes{fstype!~"tmpfs|fuse.lxcfs|squashfs"} * 100
```
Монитор памяти:
```
node_memory_Active_bytes / on (instance) node_memory_MemTotal_bytes * 100
```
Монитор Сpu
```
100 * (1 - avg by(instance)(irate(node_cpu_seconds_total{mode='idle'}[1m])))
```

Task 4: \
[дашборд](monitoring/grafana/configuration/dashboards/DevOps-base-1.json)
