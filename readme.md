# HOMELAB

personal ansible playbooks for homelab provisioning

## STRUCTURE

there is an ansible role for each specific server configuration and a playbook that runs that role against hosts defined in the [inventory](./notes/pages/INVENTORY%20STRUCTURE.md)

## SECRETS

secrets are managed trough a script called `create-vault.sh`, you need to [run it](./notes/pages/SECRETS.md) before using any playbook

## FEATURES 

- [LDAP server setup](notes/pages/LDAP%20SERVER%20INSTALLATION.md)
- [LDAP client setup](notes/pages/LDAP%20LOGIN%20SETUP.md)
- [dnsmasq setup](notes/pages/DNSMASQ.md)
- [homer setup](notes/pages/HOMER.md)
- [nextcloud setup](notes/pages/INSTALL%20NEXTCLOUD.md)
- [portainer dashboard setup](notes/pages/INSTALL%20PORTAINER%20DASHBOARD.md)
- [portainer agent setup](notes/pages/INSTALL%20PORTAINER%20AGENT.md)
- [install minecraft](notes/pages/INSTALL%20MINECRAFT.md)

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

