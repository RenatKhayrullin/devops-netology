Task 1:
1. Добавим системного пользователя под которым будет работать node_exporter
```
sudo useradd -r -M -s /bin/false node_exporter
```
3. Скачиваем node exporter
```
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
```
2. Разархивируем
```
tar xvfz node_exporter-1.2.2.linux-amd64.tar.gz
```
3. Переместим бинарники в ```/usr/local/bin```
```
sudo mv node_exporter-1.2.2.darwin-amd64/node_exporter /usr/local/bin
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
```
4. Создадим systemd сервис
```
sudo vi /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
Documentation=https://github.com/prometheus/node_exporter
After=network.target
 
[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5
EnvironmentFile=/etc/default/node_exporter
ExecStart=/usr/local/bin/node_exporter $OPTIONS
 
[Install]
WantedBy=multi-user.target
```
5. Создадим OPTIONS файл
```
sudo vim /etc/default/node_exporter

OPTIONS=''

sudo chown node_exporter:node_exporter /etc/default/node_exporter
```
6. Регистрируем node exporter как системный сервис
```
sudo systemctl daemon-reload
sudo systemctl enable --now node_exporter
sudo systemctl status node_exporter
```

Task 2:
CPU:
```
curl -s localhost:9100/metrics | grep node_cpu_seconds_total
```
Вывод:
```
user — время выполнения обычных процессов, которые выполняются в режиме пользователя (в user mode, userland);
nice — время выполнения процессов с приоритетом nice, которые выполняются в режиме пользователя;
system — время выполнения процессов, которые выполняются в режиме ядра (kernel mode);
idle — время простоя, CPU ничем не занят;
iowait — время ожидания I/O операций;
irq и softirq — время обработки аппаратных и программных прерываний;
steal — время, которое используют другие операционные системы (при виртуализации);
guest — время выполнения «гостевых» процессов (при виртуализации).

node_cpu_seconds_total{cpu="0",mode="idle"} 5441.73
node_cpu_seconds_total{cpu="0",mode="iowait"} 1.56
node_cpu_seconds_total{cpu="0",mode="irq"} 0
node_cpu_seconds_total{cpu="0",mode="nice"} 0
node_cpu_seconds_total{cpu="0",mode="softirq"} 0.52
node_cpu_seconds_total{cpu="0",mode="steal"} 0
node_cpu_seconds_total{cpu="0",mode="system"} 3.94
node_cpu_seconds_total{cpu="0",mode="user"} 3.06
node_cpu_seconds_total{cpu="1",mode="idle"} 5446.77
node_cpu_seconds_total{cpu="1",mode="iowait"} 1.71
node_cpu_seconds_total{cpu="1",mode="irq"} 0
node_cpu_seconds_total{cpu="1",mode="nice"} 0
node_cpu_seconds_total{cpu="1",mode="softirq"} 0.5
node_cpu_seconds_total{cpu="1",mode="steal"} 0
node_cpu_seconds_total{cpu="1",mode="system"} 2.85
node_cpu_seconds_total{cpu="1",mode="user"} 2.28
node_cpu_seconds_total{cpu="2",mode="idle"} 5444.82
node_cpu_seconds_total{cpu="2",mode="iowait"} 2.34
node_cpu_seconds_total{cpu="2",mode="irq"} 0
node_cpu_seconds_total{cpu="2",mode="nice"} 0
node_cpu_seconds_total{cpu="2",mode="softirq"} 0.3
node_cpu_seconds_total{cpu="2",mode="steal"} 0
node_cpu_seconds_total{cpu="2",mode="system"} 2.87
node_cpu_seconds_total{cpu="2",mode="user"} 2.39
node_cpu_seconds_total{cpu="3",mode="idle"} 5447.43
node_cpu_seconds_total{cpu="3",mode="iowait"} 0.95
node_cpu_seconds_total{cpu="3",mode="irq"} 0
node_cpu_seconds_total{cpu="3",mode="nice"} 0
node_cpu_seconds_total{cpu="3",mode="softirq"} 0.38
node_cpu_seconds_total{cpu="3",mode="steal"} 0
node_cpu_seconds_total{cpu="3",mode="system"} 2.3
node_cpu_seconds_total{cpu="3",mode="user"} 2.41
```
DISK:
```
curl -s localhost:9100/metrics | grep node_filesystem_avail_bytes
```
Вывод:
```
node_filesystem_avail_bytes{device="/dev/mapper/vgvagrant-root",fstype="ext4",mountpoint="/"} 6.0232269824e+10
node_filesystem_avail_bytes{device="/dev/sda1",fstype="vfat",mountpoint="/boot/efi"} 5.35801856e+08
node_filesystem_avail_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run"} 2.07671296e+08
node_filesystem_avail_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run/lock"} 5.24288e+06
node_filesystem_avail_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run/user/1000"} 2.0836352e+08
node_filesystem_avail_bytes{device="vagrant",fstype="vboxsf",mountpoint="/vagrant"} 8.9113030656e+10
```
NETWORK:
```
curl -s localhost:9100/metrics | grep node_network_receive_bytes_total
```
Вывод:
```
node_network_receive_bytes_total{device="eth0"} 1.5233281e+07
node_network_receive_bytes_total{device="lo"} 382612
```
MEMORY:
```
curl -s localhost:9100/metrics | grep node_memory_MemFree
```
Вывод:
```
node_memory_MemFree_bytes 1.31555328e+09
```

Task 3:
#(Ооочень крутая штука! Автоматом показывает утилизацию по запущенным процессам)
Netdata (https://github.com/netdata/netdata) конфиг.
```
sudo apt install -y netdata
```
```
[global]
	run as user = netdata
	web files owner = root
	web files group = root
	# Netdata is not designed to be exposed to potentially hostile
	# networks. See https://github.com/netdata/netdata/issues/164
	bind socket to IP = 0.0.0.0
```
Vagrant конфиг.
```
...
  config.vm.network "forwarded_port", guest: 8200, host: 8200
  config.vm.network "forwarded_port", guest: 19999, host: 19999
...
```
Некоторые метрики со страницы System Overview:
1. Total CPU utilization (all cores). 100% here means there is no CPU idle time at all. You can get per core usage at the CPUs section and per application usage at the Applications Monitoring section.
2. Current system load, i.e. the number of processes using CPU or waiting for system resources (usually CPU and disk). The 3 metrics refer to 1, 5 and 15 minute averages. The system calculates this once every 5 seconds.
3. Total Disk I/O, for all physical disks.

Task 4:
```
sudo dmesg | grep "Hypervisor detected" <-- если система на физической тачке, результат будет пустым
```
Результат:
```
[    0.000000] Hypervisor detected: KVM
```

Task 5:
```
sysctl fs.nr_open

fs.nr_open = 1048576 <-- 1024^2
```
The value of "Max open files descriptors" (ulimit -n) is limited to fs.nr_open value.

Task 6:
```
sudo -i

```

Task 7: \
```:(){ :|:& };:``` -- функция bash, которая рекурсивно делает fork(). \
```ulimit -u``` -- показывает максимальное число процессов которе можно запустить в OS. \
```ulimit -S -u [num]``` -- ограничивает число процессов, которое можно запустить в текущей сессии терминала.
```
cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope
```
```cgroups``` -- группа процессов в Linux, которая ограничивает использование ресурсов.\
Можно ограничить ресурсы пользователя через ```cgroup-tools```.
