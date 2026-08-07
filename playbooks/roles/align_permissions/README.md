align_permissions
=========

Set permissions on specific directories to keep compatibility with services requirements

Requirements
------------

None

Role Variables
--------------

See defaults/main.yml for a list of variables that can be set for this role. Variables can be set in the playbook or in inventory files.

Dependencies
------------

None

Example Playbook
----------------

- configure directories on docker clouds

```yaml
- hosts: docker_clouds
  roles:
    - align_permissions
```

License
-------

MIT

Author Information
------------------

Carnivuth
