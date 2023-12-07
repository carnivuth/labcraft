# HOMELAB

personal ansible playbooks for homelab provisioning

this repository contains the configuration and setups for my personal homelab equipment, it's meant to be runned on a proxmox cluster but it can provision other sistem with the right inventory ;)

## INVENTORY

inventory must have a specific structure for the playboooks to work see [this](notes/pages/INVENTORY%20STRUCTURE.md) for reference

## STRUCTURE

there is an ansible role for each specific server configuration and a playbook that runs that role against hosts defined in the [inventory](./notes/pages/INVENTORY%20STRUCTURE.md)

## SECRETS

secrets are managed trough a script called `create-vault.sh`, you need to [run it](./notes/pages/SECRETS.md) before using any playbook

for playbooks that use secrets you need to run them with `--ask-vault-pass` parameter

## FEATURES 

- ### [LDAP server setup](notes/pages/roles/LDAP%20SERVER%20INSTALLATION.md)

    LDAP server installation and configuration

- ### [LDAP client setup](notes/pages/roles/LDAP%20LOGIN%20SETUP.md)

    LDAP client configuration for login

- ### [install dnsmasq](notes/pages/roles/INSTALL_DNSMASQ.md)

    DNSMASQ host setup

- ### [install homer dashboard](notes/pages/roles/INSTALL_HOMER_DASHBOARD.md)

    homer dashboard installation and configuration

- ### [install nextcloud](notes/pages/roles/INSTALL_NEXTCLOUD.md)

    nextcloud installation and configuration

- ### [install docker](notes/pages/roles/INSTALL_DOCKER.md)

    docker installation and configuration

- ### [install portainer dashboard](notes/pages/roles/INSTALL_PORTAINER_DASHBOARD.md)

    portainer-ce dashboard installation and configuration

- ### [install portainer agent](notes/pages/roles/INSTALL_PORTAINER_AGENT.md)

    portainer-agent installation and configuration

- ### [install minecraft](notes/pages/roles/INSTALL_MINECRAFT.md)

    minecraft server installation and configuration

- ### [install xonotic](notes/pages/roles/INSTALL_XONOTIC.md)

    xonotic server installation and configuration

- ### [install wireguard](notes/pages/roles/INSTALL_WIREGUARD.md)

    wireguard vpn installation and configuration

- ### [configure provisioner](notes/pages/CONFIGURE_PROVISIONER.md)

    provisioner machine configuration

## USAGE

- create an inventory file for your needs with the correct [structure](notes/pages/INVENTORY%20STRUCTURE.md)

- run `ansible-playbook -i inventory/production.yaml <insert_playbook> `

## TESTING 

there is also a vagrant vm cluster for testing, to test:

- install virtualbox
- install vagrant
- enter `staging` dir
- run `./start` to create and run the cluster
- run `ansible-playbook -i inventory/testing.yaml <insert_playbook> `

