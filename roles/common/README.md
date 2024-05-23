carnivuth.labcraft.common
=========

Run some default configurations

Requirements
------------

None

Role Variables
--------------

admin_user: name of the admin user of the system
admin_home: path to the home of the admin user
admin_password: admin password
admin_comment: admin comment
admin_key: admin ssh public key

Dependencies
------------

None

Example Playbook
----------------


    - hosts: servers
      roles:
         - { role: carnivuth.labcraft.common}

License
-------


Author Information
------------------

carnivuth
