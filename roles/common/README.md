carnivuth.labcraft.common
=========

perform default configuration on machines, setup vim with personal configurations and install some default packages

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

ansible.community.general

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
