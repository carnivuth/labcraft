align_cloudflare_dns
=========

Configure Cloudflare dns to the current state of the cluster, add a .local.domain record for each node inside the network pointing to local address and align ddns

Requirements
------------

None

Role Variables
--------------

Check default variables in `defaults/main.yml` for more information.

Dependencies
------------

None

Example Playbook
----------------

```yaml
---
- name: Run torterra site configuration
  hosts:
    - servers
  roles:
    - align_cloudflare_dns
```

License
-------

MIT

Author Information
------------------

Carnivuth
