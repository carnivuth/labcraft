#!/bin/bash
cd /usr/local/labcraft && source env/bin/activate && ansible-playbook -i inventory/inventory.proxmox.yml playbooks/do_backup.yml
