# HOMELAB

personal ansible playbooks for homelab provisioning

## FEATURES 

- LDAP server setup
- LDAP client setup

## USAGE

- replace all `sample` files with the corrisponding files and set the values

- edit `inventory/production.yaml` to suits your needs

- run `ansible-playbook -i inventory/production.yaml all.yaml `


## TESTING 

there is also a vagrant vm cluster for staging, to test:

- replace all `sample` files with the corrisponding files and set the values
- install virtualbox
- install vagrant
- enter `staging` dir
- run `./start` to create and run vms
- run `ansible-playbook -i inventory/staging.yaml all.yaml `

