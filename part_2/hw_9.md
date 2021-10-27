Task 1: \
[docker файл](hw9/Dockerfile) \
[docker compose файл](hw9/docker-compose.yml) \
[docker образ](https://hub.docker.com/repository/docker/kh4k1/elastic-netology) 

Запустим elasticsearch из docker-compose \
Наберем в браузере
```
localhost:9200
```
Ответ:
```
{
  "name" : "netology_test",
  "cluster_name" : "netology_cluster",
  "cluster_uuid" : "9CwJr593Sg61WmqbGLcTTQ",
  "version" : {
    "number" : "7.15.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "83c34f456ae29d60e94d886e455e6a3409bba9ed",
    "build_date" : "2021-10-07T21:56:19.031608185Z",
    "build_snapshot" : false,
    "lucene_version" : "8.9.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

Task 2: \
[создание индексов](hw9/create_index.sh) \

Список индексов
```
http://localhost:9200/_cat/indices/ind*?v&s=index
```
Ответ:
```
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 BxLPjrwvT9OxOQtJ7oX_cg   1   0          0            0       208b           208b
yellow open   ind-2 CMzIw78VTfWjWP54S0VHZQ   2   1          0            0       416b           416b
yellow open   ind-3 KOuWSrjERxe-FmSlINWXsQ   4   2          0            0       832b           832b
```

Состояние кластера: 

```
http://localhost:9200/_cluster/state/master_node,nodes,metadata/ind*
```
Результат для ind-1, ind-2, ind-3:
```
{
  "cluster_name": "netology_cluster",
  "cluster_uuid": "9CwJr593Sg61WmqbGLcTTQ",
  "master_node": "JZNuXWhsSP2sj1GhTeorcw",
  "nodes": {
    "JZNuXWhsSP2sj1GhTeorcw": {
      "name": "netology_test",
      "ephemeral_id": "LIv8IFNSTeSfnntREvUQRQ",
      "transport_address": "192.168.0.2:9300",
      "attributes": {
        "ml.machine_memory": "2082197504",
        "xpack.installed": "true",
        "transform.node": "true",
        "ml.max_open_jobs": "512",
        "ml.max_jvm_size": "1040187392"
      },
      "roles": [
        "data",
        "data_cold",
        "data_content",
        "data_frozen",
        "data_hot",
        "data_warm",
        "ingest",
        "master",
        "ml",
        "remote_cluster_client",
        "transform"
      ]
    }
  },
  "metadata": {
    "cluster_uuid": "9CwJr593Sg61WmqbGLcTTQ",
    "cluster_uuid_committed": false,
    "cluster_coordination": {
      "term": 1,
      "last_committed_config": [
        "JZNuXWhsSP2sj1GhTeorcw"
      ],
      "last_accepted_config": [
        "JZNuXWhsSP2sj1GhTeorcw"
      ],
      "voting_config_exclusions": []
    },
    "templates": {},
    "indices": {
      "ind-2": {
        "version": 5,
        "mapping_version": 1,
        "settings_version": 1,
        "aliases_version": 1,
        "routing_num_shards": 1024,
        "state": "open",
        "settings": {
          "index": {
            "routing": {
              "allocation": {
                "include": {
                  "_tier_preference": "data_content"
                }
              }
            },
            "number_of_shards": "2",
            "provided_name": "ind-2",
            "creation_date": "1635373735292",
            "number_of_replicas": "1",
            "uuid": "CMzIw78VTfWjWP54S0VHZQ",
            "version": {
              "created": "7150199"
            }
          }
        },
        "mappings": {},
        "aliases": [],
        "primary_terms": {
          "0": 1,
          "1": 1
        },
        "in_sync_allocations": {
          "0": [
            "YuOJj-rXROCzs-ig0cTV8A"
          ],
          "1": [
            "_J6z_quKRvaUHGgqTlwPgQ"
          ]
        },
        "rollover_info": {},
        "system": false,
        "timestamp_range": {
          "unknown": true
        }
      },
      "ind-1": {
        "version": 4,
        "mapping_version": 1,
        "settings_version": 1,
        "aliases_version": 1,
        "routing_num_shards": 1024,
        "state": "open",
        "settings": {
          "index": {
            "routing": {
              "allocation": {
                "include": {
                  "_tier_preference": "data_content"
                }
              }
            },
            "number_of_shards": "1",
            "provided_name": "ind-1",
            "creation_date": "1635373714781",
            "number_of_replicas": "0",
            "uuid": "BxLPjrwvT9OxOQtJ7oX_cg",
            "version": {
              "created": "7150199"
            }
          }
        },
        "mappings": {},
        "aliases": [],
        "primary_terms": {
          "0": 1
        },
        "in_sync_allocations": {
          "0": [
            "G2WkTkYtQOSwRcE2JLi_IQ"
          ]
        },
        "rollover_info": {},
        "system": false,
        "timestamp_range": {
          "unknown": true
        }
      },
      "ind-3": {
        "version": 5,
        "mapping_version": 1,
        "settings_version": 1,
        "aliases_version": 1,
        "routing_num_shards": 1024,
        "state": "open",
        "settings": {
          "index": {
            "routing": {
              "allocation": {
                "include": {
                  "_tier_preference": "data_content"
                }
              }
            },
            "number_of_shards": "4",
            "provided_name": "ind-3",
            "creation_date": "1635373736306",
            "number_of_replicas": "2",
            "uuid": "KOuWSrjERxe-FmSlINWXsQ",
            "version": {
              "created": "7150199"
            }
          }
        },
        "mappings": {},
        "aliases": [],
        "primary_terms": {
          "0": 1,
          "1": 1,
          "2": 1,
          "3": 1
        },
        "in_sync_allocations": {
          "0": [
            "RTmr-GrjSguNSmUNsfOn8Q"
          ],
          "1": [
            "qPCYZFX6SvOyTYLGy6qrBQ"
          ],
          "2": [
            "5oZA2m3JR2CmRKixzfuzQw"
          ],
          "3": [
            "yJdRR6RtQCOf4IPr46yqyg"
          ]
        },
        "rollover_info": {},
        "system": false,
        "timestamp_range": {
          "unknown": true
        }
      }
    },
    "index-graveyard": {
      "tombstones": []
    }
  }
}
```

Yellow состояние из-за того, для индексов есть primary shard и недостаточно сегментов реплик, относительно конфига. \
Иными словами из-за того, что кластер -- single-node, и индексам ind-2,3 не хватает нод и шард для репликации. \

[удаление индексов](hw9/delete_index.sh)

Task 3:

