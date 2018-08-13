#! /bin/bash

echo "Creating app config keys in Consul"

consul kv put product_conf/DB_ADDR 127.0.0.1
consul kv put product_conf/DB_PORT 5001
consul kv put listing_conf/DB_URL 127.0.0.1
consul kv put listing_conf/DB_PORT 8001
consul kv put web_client_conf/LISTING_URI http://localhost:10002
consul kv put web_client_conf/PRODUCT_URI http://localhost:10001