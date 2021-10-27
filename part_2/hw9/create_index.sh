set -e

curl -X PUT localhost:9200/ind-1 \
     -H 'Content-Type: application/json' \
     -d \
      '{
        "settings": {
          "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0
          }
        }
      }' \
&&
curl -X PUT localhost:9200/ind-2 \
     -H 'Content-Type: application/json' \
     -d \
      '{
        "settings": {
          "index": {
            "number_of_shards": 2,
            "number_of_replicas": 1
          }
        }
      }' \
&&
curl -X PUT localhost:9200/ind-3 \
     -H 'Content-Type: application/json' \
     -d \
      '{
        "settings": {
          "index": {
            "number_of_shards": 4,
            "number_of_replicas": 2
          }
        }
      }'
