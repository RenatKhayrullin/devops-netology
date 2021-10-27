set -e

curl -X DELETE localhost:9200/ind-1 && \
curl -X DELETE localhost:9200/ind-2 && \
curl -X DELETE localhost:9200/ind-3