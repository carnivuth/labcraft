carnivuth.labcraft.install_curiel_bot
=========

Install curiel bot on the target machine

Requirements
------------

None

Role Variables
--------------

    data_dir: data directory where curiel bot files are stored default= /mnt/storage
    conf_dir: configuration directory where env file is stored default /etc
    curiel_bot_token: token for access telegram API
    curiel_bot_admin: telegram username of the admin account that should be allowed to run admin commands

Dependencies
------------

 geerlingguy.docker role for installing docker on the host machine

Example Playbook
----------------


    - hosts: curiel_bot_host
      roles:
         - { role: carnivuth.labcraft.install_curiel_bot}

License
-------


Author Information
------------------

carnivuth
