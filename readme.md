# HOMELAB

personal ansible playbooks for homelab provisioning

## STRUCTURE

there is an ansible role for each specific server configuration and a playbook that runs that role against hosts defined in the [inventory](./notes/pages/INVENTORY%20STRUCTURE.md)


## FEATURES 

- [LDAP server setup](notes/pages/LDAP%20SERVER%20INSTALLATION.md)
- [LDAP client setup](notes/pages/LDAP%20LOGIN%20SETUP.md)
- [docker runtime setup](notes/pages/)

## SECRETS

secrets are managed trough a script called `create-vault.sh`, you need to [run it](./notes/pages/SECRETS.md) before using any playbook

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

