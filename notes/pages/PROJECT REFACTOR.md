# PROJECT REFACTOR

## GOALS

- reduce codebase dimension to improve maintainability
- new operative workflow definitions
	- new machine creation 
	- data backup operations?
- add automated test framework to the stack

## TESTS 

create ansible tests with molecule on all  instances, 

## INVENTORY 

Manage prod inventory with [proxmox plugin](https://docs.ansible.com/ansible/latest/collections/community/general/proxmox_inventory.html) in order to reduce the codebase and improve the new container workflow

## WORKFLOW

use proxmox machine tags together with ansible to retrieve information on ansible groups and change the inventory structure accordingly

## AUTOMATION

Initial research on how to automate the provisioning process (maybe using jenkins?)

### SECRET MANAGEMENT 

improve secrets management to allow ansible to recover them at runtime in non interactive way
