# ansible-haproxy
Ansible to Deploy two tiers of HAProxy loadbalancers with Keepalived for VRRP

## Requirements

* Tailscale installed and configured for ssh
    ```bash
    sudo tailscale up --ssh --advertise-tags "tag:servers,tag:haproxy"
    ```

## Run

```bash
ansible-playbook -i hosts setup.yaml -v --diff
ansible-playbook -i hosts site.yaml -v --diff
```