# ansible-haproxy
Ansible to Deploy two tiers of HAProxy loadbalancers with Keepalived for VRRP

## Run

```bash
ansible-playbook -i hosts site.yaml -v --diff
```