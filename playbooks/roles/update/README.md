Update
=========

Update targets, installs a set of default packages and send telegram notification with package diffs debian only

Requirements
------------

None

Role Variables
--------------

Check the defaults/main.yml file for variables and their default values.

Dependencies
------------

None

Example Playbook
----------------

- update targets, install a set of default packages and send telegram notification with package diffs debian only

```yaml

- name: Run updates
  hosts:
    - servers
  roles:
    - update
```

License
-------

MIT

Author Information
------------------

Carnivuth
