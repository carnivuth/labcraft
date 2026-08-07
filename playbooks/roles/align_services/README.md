align_services
=========

Installs services inside a docker cloud and configure dns cname records

Requirements
------------

None

Role Variables
--------------

See defaults/main.yml for a full list of variables and their default values.

Dependencies
------------

None

Example Playbook
----------------

- install only navidrome traefik authelia grafana and prometheus

```yaml
- hosts: servers
  roles:
    - align_services
  vars:
    align_services_apps:
        - "traefik"
        - "authelia"
        - "prometheus"
        - "grafana"
        - "navidrome"
```

- install all services

```yaml
- hosts: servers
  roles:
    - align_services
```

License
-------

MIT

Author Information
------------------

Carnivuth
