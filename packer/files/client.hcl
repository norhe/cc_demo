client_addr      = "0.0.0.0"
data_dir         = "/opt/consul"
datacenter       = "east"
log_level        = "INFO"
server           = false
acl_datacenter   = "east"
acl_down_policy  = "extend-cache"
retry_join       = [
    "provider=gce project_name=connect-env tag_value=consul-server"
]