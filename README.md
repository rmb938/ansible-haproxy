# ansible-haproxy
Ansible to Deploy two tiers of HAProxy loadbalancers with Keepalived for VRRP

## Requirements

* Tailscale installed and configured for ssh
    ```bash
    sudo tailscale up --ssh --advertise-tags "tag:servers,tag:haproxy"
    ```
* Create SmallStep Provisioner for each T2 host
    ```bash
    mkdir -p /etc/step/templates
    cat << EOF > /etc/step/templates/x509-load-balancing.tpl
    {
        "subject": {
        "commonName": {{ toJson .Subject.CommonName }},
        "country": "US",
        "organization": "Home Lab",
        "organizationalUnit": "Load Balancing",
        "province": "Minnesota"
    },
            "sans": {{ toJson .SANs }},
    {{- if typeIs "*rsa.PublicKey" .Insecure.CR.PublicKey }}
            "keyUsage": ["keyEncipherment", "digitalSignature"],
    {{- else }}
            "keyUsage": ["digitalSignature"],
    {{- end }}
            "extKeyUsage": ["serverAuth", "clientAuth"]
    }
    EOF
    STEP_CONSOLE=true STEPPATH=/etc/step step ca provisioner add $(hostname -f) --type JWK --create --password-file /etc/ssh/ssh_host_ed25519_key --disable-ssh-ca-user --disable-ssh-ca-host --x509-min-dur=2190h --x509-max-dur=2190h --x509-default-dur=2190h --ssh=false --x509-template /etc/step/templates/x509-load-balancing.tpl --admin-subject dummy@example.com
    STEP_CONSOLE=true STEPPATH=/etc/step step ca policy provisioner x509 allow dns '*.haproxy.rmb938.me' --provisioner $(hostname -f) --admin-subject dummy@example.com
    ```

## Run

```bash
ansible-playbook -i hosts site.yaml -v --diff
```