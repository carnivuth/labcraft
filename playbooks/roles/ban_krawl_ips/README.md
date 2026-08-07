ban_krawl_ips
=========

Ban Krawl IPs on targets by adding iptables

Requirements
------------

None

Role Variables
--------------

Check the `defaults/main.yml` file for a list of variables that can be set for this role. Some variables worth noticing are:

```yaml
---
ban_krawl_ips_categories: # krawl categories to target for ban
ban_krawl_ips_urls: # list of krawl instances to query to get attackers to ban
```

Dependencies
------------

None

Example Playbook
----------------
- ban all krawl attackers from demo instance

```yaml
- hosts: servers
  roles:
    - roles/ban_krawl_ips
  vars:
    ban_krawl_ips_categories:
      - attacker
    ban_krawl_ips_urls:
      - http://demo.krawlme.com/das_dashboard/api/export-ips?categories={{ ban_krawl_ips_categories | join(',') }}&fwtype=raw
```

License
-------

MIT

Author Information
------------------

Carnivuth
