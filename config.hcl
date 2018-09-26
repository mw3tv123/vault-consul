storage "consul" {
  address = "172.25.234.118:8500"
  path    = "/opt/consul/storage"
}

ui = true

listener "tcp" {
 address     = "172.25.234.118:8200"
 tls_disable = 1
}
