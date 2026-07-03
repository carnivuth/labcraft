align_services
=========

Installs services inside docker host

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

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: servers
  roles:
    - roles/align_services
  vars:
    align_services_apps:
        - "traefik"
```

License
-------

MIT

Author Information
------------------

Carnivuth
