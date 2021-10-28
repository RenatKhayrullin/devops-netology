set -e

curl -X PUT localhost:9200/_snapshot/netology_backup \
     -H 'Content-Type: application/json' \
     -d \
      '{
          "type": "fs",
          "settings": {
              "location": "/home/elastic/elasticsearch-7.15.1/snapshots"
          }
      }'
&&
curl -X PUT localhost:9200/test \
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
curl -X PUT "localhost:9200/_snapshot/netology_backup/shapshot_1?wait_for_completion=true" \
     -H 'Content-Type: application/json' \
     -d \
      '{
          "indices": "test"
      }' \
&&
curl -X DELETE localhost:9200/test \
&&
curl -X PUT localhost:9200/test-2 \
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
curl -X POST localhost:9200/_snapshot/netology_backup/shapshot_1/_restore \
     -H 'Content-Type: application/json' \
     -d \
      '{
          "indices": "test"
      }'