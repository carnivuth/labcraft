provision_grafana
=========

Provision grafana trough configuration files and send notifications

Requirements
------------

None

Role Variables
--------------

See default/main.yml

Dependencies
------------

None

Example Playbook
----------------

- install monitoring stack and configure grafana

```yaml
---
- hosts: docker_clouds
  remote_user: root
  roles:
    - role: ../../align_services
      vars:
        align_services_apps:
          - traefik
          - authelia
          - prometheus
          - node_exporter
          - grafana
    - ../../provision_grafana
    - role: ../../align_permissions
```

License
-------

MIT

Author Information
------------------

Carnivuth
