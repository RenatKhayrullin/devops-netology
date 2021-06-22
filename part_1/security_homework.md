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
        common_name="devops.netology.com" \
        ttl=87600h > RootCA.crt
```

Обновляем пути до issuing сертификатов и CRL
```
vault write pki/config/urls \
    issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
    crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"
```

Task 4:

Создаем intermediate сертификат
```
vault secrets enable -path=pki_int pki
vault secrets tune -max-lease-ttl=43800h pki_int

vault write -format=json pki_int/intermediate/generate/internal \
      common_name="devops.netology.com Intermediate Authority" \
      | jq -r '.data.csr' > IntermediateCA.csr
```

Подписываем сертификат

```
vault write -format=json pki/root/sign-intermediate csr=@IntermediateCA.csr \
        format=pem_bundle ttl="43800h" \
        | jq -r '.data.certificate' > intermediate.cert.pem
        
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem

vault write pki_int/config/urls \ 
        issuing_certificates="http://127.0.0.1:8200/v1/pki_int/ca" \ 
        crl_distribution_points="http://127.0.0.1:8200/v1/pki_int/crl"
```

Task 5:

Ставим nginx

```
sudo apt update
sudo apt install nginx

По факту не потребовалось так как ufw выключен
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
mkdir -p /var/www/devops.netology.com/html/
sudo vim /var/www/devops.netology.com/html/index.html
```

index.html

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

Дадим права.

```
sudo chown -R $USER:$USER /var/www/devops.netology.com/html
sudo chmod -R 755 /var/www/devops.netology.com/html/index.html
```

Настроим доступ к странице через nginx.

```
cd /etc/nginx/sites-available
sudo vim devops.netology.com
```

Содержимое конфига.

```
server {
        listen 80;
        listen [::]:80;

        root /var/www/devops.netology.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name devops.netology.com www.devops.netolgy.com;

        location / {
                try_files $uri $uri/ =404;
        }
}
```

Пробросим симлинк.

```
sudo ln -s /etc/nginx/sites-available/devops.netology.com /etc/nginx/sites-enabled/
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
sudo ln -s intermediate.cert.pem /etc/ssl/certs/IntermediateCA.csr
```

Добавляем в настройки сайта поддержку сертификатов.

```
server {
        ...
        ssl_certificate /etc/ssl/certs/IntermediateCA.csr;
        ssl_certificate_key <не пойму где его взять при генерации сертификата через vault>;
        ...
}
```

Task 6:

Устанавливаем сертификаты в систему как локальный сертификат.

```
sudo cp intermediate.cert.pem /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

Отправляем запрос.
```
curl -v --request GET https://localhost:80
```