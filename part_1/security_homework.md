Task 1:

Task 2:

Запускаем VAULT сервер
```
vault server -dev -dev-listen-address="0.0.0.0:8200"
```

Task 3-4:

В соседней консоли.

Включаем PKI и устанавливаем TTL
```
export VAULT_ADDR=http://0.0.0.0:8200

vault secrets enable pki

vault secrets tune -max-lease-ttl=8760h pki
```

Создаем RootCA сертификат
```
vault write -format=json pki/root/generate/internal \
 common_name="pki-ca-root" ttl=87600h | tee \
>(jq -r .data.certificate > ca.pem) \
>(jq -r .data.issuing_ca > issuing_ca.pem) \
>(jq -r .data.private_key > ca-key.pem)
```

Создаем IntermediateCA сертификат

1. Перенастроим пути в Vault c pki на pki_int
```
vault secrets enable -path pki_int pki
```
2. Сгенерируем внутренний IntermediateCA сертификат
```
vault write -format=json pki_int/intermediate/generate/internal \
common_name="pki-ca-int" ttl=43800h | tee \
>(jq -r .data.csr > pki_int.csr) \
>(jq -r .data.private_key > pki_int.pem)
```
3. Подпишем и установим IntermediateCA с помощью RootCA
```
vault write -format=json pki/root/sign-intermediate \
csr=@pki_int.csr \
common_name="pki-ca-int" ttl=43800h | tee \
>(jq -r .data.certificate > pki_int.pem) \
>(jq -r .data.issuing_ca > pki_int_issuing_ca.pem)

vault write pki_int/intermediate/set-signed certificate=@pki_int.pem
```

4. Создадим роль для выпуска сертификатов для клиентов
```
vault write pki_int/roles/netology-example-com \
allowed_domains=example.com \ <-- базовый домен
allow_subdomains=true \ <-- разрешаем subdomain'ы вида *.example.com
max_ttl="40h" \ <-- устанавливаем время жизни выпущенных сертификатов
generate_lease=true
```

5. Создадим директорию для хранения сертификатов nginx
```
mkdir /etc/nginx/certs
```

6. Сгенерируем сертификаты для домена netology.example.com
```
sudo -s

export VAULT_ADDR=http://0.0.0.0:8200
export VAULT_TOKEN=<токен от vault>

cd /etc/nginx/certs

vault write -format=json pki_int/issue/netology-example-com \
common_name=netology.example.com | tee \
>(jq -r .data.certificate > netology.crt) \
>(jq -r .data.issuing_ca > issuing_netology.crt) \
>(jq -r .data.private_key > netology.key)

sudo chown -R $USER:$USER *
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
        <h1>Success! The netology.example.com server block is working!</h1>
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
        index index.html;
        server_name netology.example.com www.netology.example.com;
        return 301  https://netology.example.com$request_uri;
        return 301  https://www.netology.example.com$request_uri;
}

server {
        listen              443 ssl http2 default_server;
        server_name         netology.example.com www.netology.example.com;
        ssl_certificate     /etc/nginx/certs/netology.crt;
        ssl_certificate_key /etc/nginx/certs/netology.key;
        ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;

        location / {
            root   /var/www/netology.example.com/html;
            index  index.html;
        }
}
```

Пробросим симлинк.

```
sudo ln -s /etc/nginx/sites-available/netology.example.com /etc/nginx/sites-enabled/
systemctl reload nginx
```

Task 6:

Подправим /etc/hosts
```
127.0.0.1	localhost
127.0.0.1   netology.example.com
127.0.1.1	vagrant.vm	vagrant
```

Отправляем запрос.
```
curl -v https://netology.example.com
```

Возвращается ответ:
```
*   Trying 127.0.0.1:443...
* TCP_NODELAY set
* Connected to netology.example.com (127.0.0.1) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (OUT), TLS alert, unknown CA (560):
* SSL certificate problem: unable to get local issuer certificate
* Closing connection 0
curl: (60) SSL certificate problem: unable to get local issuer certificate
More details here: https://curl.haxx.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```

Возьмем сертификат pki_int.pem с шага (Task 3-4.3) и выполним
```
curl -v --cacert pki_int.pem https://netology.example.com:443
```

Возвращается ответ
```
*   Trying 127.0.0.1:443...
* TCP_NODELAY set
* Connected to netology.example.com (127.0.0.1) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: pki_int.pem
  CApath: /etc/ssl/certs
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: CN=netology.example.com
*  start date: Sep 19 20:25:06 2021 GMT
*  expire date: Sep 21 12:25:36 2021 GMT
*  subjectAltName: host "netology.example.com" matched cert's "netology.example.com"
*  issuer: CN=pki-ca-int
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x557d2f5dbe10)
> GET / HTTP/2
> Host: netology.example.com
> user-agent: curl/7.68.0
> accept: */*
>
* Connection state changed (MAX_CONCURRENT_STREAMS == 128)!
< HTTP/2 200
< server: nginx/1.18.0 (Ubuntu)
< date: Sun, 19 Sep 2021 21:30:40 GMT
< content-type: text/html
< content-length: 194
< last-modified: Tue, 22 Jun 2021 22:03:04 GMT
< etag: "60d25e18-c2"
< accept-ranges: bytes
<
<html>
    <head>
        <title>Welcome to netology.example.com!</title>
    </head>
    <body>
        <h1>Success!  The netology.example.com server block is working!</h1>
    </body>
</html>
* Connection #0 to host netology.example.com left intact
```