Task 1:

```
{   
    "info" : "Sample JSON output from our service\t",
    "elements" :[
        {   
            "name" : "first",
            "type" : "server",
            "ip" : 7175 <-- противоречий нет, но будет проблема с несогласованностью типов, хотя формально это не ошибка
        },
        { 
            "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43 <-- забыта закрывающая кавычка, ip-адрес следует взять в кавычки 
        }
    ]
}
```
Правильный JSON:

```
{
  "info" : "Sample JSON output from our service\t",
  "elements" :[
    {
      "name" : "first",
      "type" : "server",
      "ip" : "7175"
    },
    {
      "name" : "second",
      "type" : "proxy",
      "ip" : "71.78.22.43"
    }
  ]
}
```

Task 2:

У меня немного другой формат по сравнению с тем, что указан в задаче, но сути это не меняет

```
import socket
from datetime import datetime
import json
import yaml


def get_ip_address_by_host(hostname):
    return socket.gethostbyname(hostname)


if __name__ == '__main__':

    hosts = ["drive.google.com", "mail.google.com", "google.com"]

    json_file_name = "host_map.json"
    yaml_file_name = "host_map.yml"

    service_map = None

    try:
        with open(json_file_name, "r") as dump:
            service_map = json.load(dump)
    except FileNotFoundError as e:
        service_map = dict()

    for host in hosts:
        if host not in service_map:
            service_map[host] = list()

        service_map[host].append(
            {
                "date": datetime.now().strftime("%d/%m/%Y %H:%M:%S"),
                "host_ip": get_ip_address_by_host(host)
            }
        )

    with open(json_file_name, "w") as dump, \
         open(yaml_file_name, "w") as yml_dump  :
        json.dump(service_map, dump)
        yaml.dump(service_map, yml_dump)

    for k, v in service_map.items():
        print("<{}> - <{}>".format(k, v[-1]["host_ip"]))
        if len(v) > 1:
            if v[-2]["host_ip"] != v[-1]["host_ip"]:
                print("[ERROR] <{}> IP mismatch: <{}> <{}>".format(k, v[-2]["host_ip"], v[-1]["host_ip"]))
```