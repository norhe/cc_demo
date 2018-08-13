#! /bin/bash

echo "Giving consul cluster time to stabilize..."
sleep 30

echo "Creating payload"
cat >./pload <<EOF
{
  "Name": "Vault Agent Token",
  "Type": "client",
  "Rules": "{ \"key\": { \"vault/\": { \"policy\": \"write\" }  }, \"node\": { \"\": { \"policy\": \"write\" } }, \"service\": { \"vault\": { \"policy\": \"write\" } }, \"agent\": { \"\": { \"policy\": \"write\" } }, \"session\": { \"\": { \"policy\": \"write\" } } }"  
}
EOF

echo "Creating token..."
ACL_TOKEN=$(curl \
    --request PUT \
    --header "X-Consul-Token: abc123" \
    --data @pload http://127.0.0.1:8500/v1/acl/create | jq .ID | tr -d '"')

echo "$ACL_TOKEN" | sudo tee /etc/consul/agent_token

echo "Setting ACL token..."
curl \
    --request PUT \
    --header "X-Consul-Token: abc123" \
    --data \
'{
  "Token": "$ACL_TOKEN"
}' http://127.0.0.1:8500/v1/agent/token/acl_token

# use token on restart
cat >/tmp/acl_token.hcl <<EOF
acl_token = "$ACL_TOKEN"
EOF

sudo mv /tmp/acl_token.hcl

sudo systemctl disable consul_enable_acl.service