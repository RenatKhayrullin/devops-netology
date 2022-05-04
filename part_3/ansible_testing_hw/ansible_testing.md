1. Устанавливаем последнюю версию molecule (версия 3.4.0 не совместима с версией >= 6.0.0 ansible-lint)
2. Устанавливаем molecule-docker ```pip install molecule-docker```
3. Скачиваем под VPN дистрибутивы для ubuntu под VPN и кладем в директорию files внутри каждого склонированного репозитория
   ```
   https://artifacts.elastic.co/downloads/kibana/kibana-7.16.2-x86_64.rpm
   https://artifacts.elastic.co/downloads/kibana/kibana-7.16.2-amd64.deb
   https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.16.2-x86_64.rpm
   https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.16.2-amd64.deb
   ```
4. собираем docker image для tox тестов 
   ```
   cd docker_image
   docker build -t tox_test .
   ```
5. Запускаем tox тесты
   ```
   docker run --privileged=True -v <path>/kibana-role:/opt/kibana-role -w /opt/kibana-role -it tox_test /bin/bash
   docker run --privileged=True -v <path>/filebeat-role:/opt/kibana-role -w /opt/filebeat-role -it tox_test /bin/bash
   ```