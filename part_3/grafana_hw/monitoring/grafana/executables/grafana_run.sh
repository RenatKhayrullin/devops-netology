#!/bin/sh
set -e

# подставляем актуальный хост и порт prometheus в конфигурационный файл grafana (меняем разделитель у sed на '|')
sed -ri "s|^(\s*)(url\s*:\s*'.*+'\s*)|\1url: 'http://"${PROMETHEUS_URL}"'|" /etc/grafana/provisioning/datasources/all.yml && \
/run.sh