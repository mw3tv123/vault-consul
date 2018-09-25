#storage "consul" {
#  address = "192.168.81.240:8500"
#  path    = "vault"
#}

storage "file" {
  path = "/home/tqhung1/Works/DevOps/vault"
}

ui = true

listener "tcp" {
 address     = "192.168.81.156:8200"
 tls_disable = 1
}
