# {{ ansible_managed }}

vault {
  # Vault agent will connect to the Vault that is the same number as itself.
  # We are HAProxy so we are having each connect to a unique Vault. 
  address = "https://hashi-vault-{{ ansible_hostname[-1] }}.us-homelab1.hl.rmb938.me:8200"
  retry {
    num_retries = 5
  }
}

auto_auth {
  method "cert" {
    mount_path = "auth/step-cert"
    config {
      client_cert = "/opt/vault/tls/vault.crt"
      client_key = "/opt/vault/tls/vault.key"
      reload = true
    }
  }
}

api_proxy {
  use_auto_auth_token = "force"
}

listener "tcp" {
  // TODO: see if we can switch this to /run/vault/vault.sock
  address = "127.0.0.1:8100"
  tls_disable = true # no tls locally, probably not great but no easy way around it
}