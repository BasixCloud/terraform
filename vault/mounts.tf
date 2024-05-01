resource "vault_mount" "kv" {
  type = "kv-v2"
  path = "kv2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
}

