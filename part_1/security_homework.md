Task 1:

Task 2:

Запускаем VAULT сервер
```
vault server -dev -dev-listen-address="0.0.0.0:8200"
```

Task 3:

В соседней консоли.

Включаем PKI и устанавливаем TTL
```
export VAULT_ADDR=http://0.0.0.0:8200

vault secrets enable pki

vault secrets tune -max-lease-ttl=8760h pki
```

Создаем RootCA сертификат
```
vault write -field=certificate pki/root/generate/internal \
        common_name="netology.example.com" \
        ttl=87600h
```

Обновляем пути до issuing сертификатов и CRL

```
vault write pki/config/urls \
    issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
    crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"
```

Создаем роль.

```
vault write pki/roles/example-dot-com \
    allowed_domains=netology.example.com \
    allow_subdomains=true \
    max_ttl=72h
```

Task 4:

Создаем credentinal и получем IssuingCa.crt и IssuingCa.key.
```
vault write pki/issue/example-dot-com \
    common_name=www.netology.example.com
```

Task 5:

Ставим nginx

```
sudo apt update
sudo apt install nginx

По факту не потребовалось, так как ufw выключен
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
```

Проверим работу nginx.

> systemctl status nginx
> ● nginx.service - A high performance web server and a reverse proxy server \
>    Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled) \
>    Active: active (running) since Tue 2021-06-22 18:10:29 UTC; 23min ago \
>      Docs: man:nginx(8) \
>  Main PID: 2720 (nginx) \
>     Tasks: 5 (limit: 2279) \
>    Memory: 6.0M \
>    CGroup: /system.slice/nginx.service \
>            ├─2720 nginx: master process /usr/sbin/nginx -g daemon on; master_process on; \
>            ├─2721 nginx: worker process \
>            ├─2722 nginx: worker process \
>            ├─2723 nginx: worker process \
>            └─2724 nginx: worker process \
> Jun 22 18:10:29 vagrant systemd[1]: Starting A high performance web server and a reverse proxy server... \
> Jun 22 18:10:29 vagrant systemd[1]: Started A high performance web server and a reverse proxy server. \

Создадим тестовую страницу
```
mkdir -p /var/www/netology.example.com/html
sudo vim /var/www/netology.example.com/html/index.html
```

index.html

```
<html>
    <head>
        <title>Welcome to netology.example.com!</title>
    </head>
    <body>
        <h1>Success!  The netology.example.com server block is working!</h1>
    </body>
</html>
```

Дадим права.

```
sudo chown -R $USER:$USER /var/www/netology.example.com/html
sudo chmod -R 755 /var/www/netology.example.com/html/index.html
```

Настроим доступ к странице через nginx.

```
cd /etc/nginx/sites-available
sudo vim netology.example.com
```

Содержимое конфига.

```
server {
        listen 80;
        listen [::]:80;

        root /var/www/netology.example.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name netology.example.com www.netology.example.com;

        location / {
                try_files $uri $uri/ =404;
        }
}
```

Пробросим симлинк.

```
sudo ln -s /etc/nginx/sites-available/netology.example.com /etc/nginx/sites-enabled/
systemctl reload nginx
```

По обращению

```
curl --request GET "localhost:80"
```

возвращается страница

```
<html>
    <head>
        <title>Welcome to devops.netology.com!</title>
    </head>
    <body>
        <h1>Success!  The devops.netology.com server block is working!</h1>
    </body>
</html>
```

Настроим SSL.

Создадим симлинк на созданный сертификат.

```
sudo ln -s ~/IssuingCa.crt /etc/ssl/certs/Netology.example.issuing.ca.crt
sudo ln -s ~/IssuingCa.key /etc/ssl/private/Netology.example.issuing.ca.key
```

Добавляем в настройки сайта поддержку сертификатов.

```
server {
        ...
        ssl_certificate /etc/ssl/certs/Netology.example.issuing.ca.crt;
        ssl_certificate_key /etc/ssl/private/Netology.example.issuing.ca.key;
        ...
}
```

И это не съел Nginx, надо переделывать через IntemediateCa ....

Task 6:


Устанавливаем сертификаты в систему как локальный сертификат.

```
sudo cp intermediate.cert.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

Отправляем запрос.
```
curl -v --request GET https://localhost:80
```