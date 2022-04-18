#!/bin/sh
set -e

# подставляем актуальный хост и порт бэкэнд приложения в конфигурационный файл prometheus
sed -ri "s/^(\s*)(-\s*targets\s*:\s*\[.*+\]\s*$)/\1- targets: [\""${BACKEND_URL}"\"\]/" /etc/prometheus/prometheus.yml && \
/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --web.enable-lifecycle