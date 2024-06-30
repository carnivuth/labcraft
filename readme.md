# LABCRAFT

Personal ansible collection for homelab management over proxmox virtual environment

## INSTALLATION

- clone repository

```bash
git clone https://github.com/carnivuth/labcraft
```

- create venv and install dependencies

```bash
cd labcraft
python -m venv env
source env/bin/activate
pip install -r requirements.txt
```

- install ansible collections and roles

```bash
source env/bin/activate
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.general
ansible-galaxy role install geerlingguy.docker
```

- link the collection inside `~/.ansible/collections/ansible_collections/`

- create inventory following the template in `inventory/inventory.proxmox.yml`

```bash
cp inventory/inventory.proxmox.yml inventory/inventory.proxmox.yml
```

- run playbooks

## ROLES

- [common configuration for containers and vms](./roles/common/README.md)
- [dnsmasq configuration](./roles/install_dnsmasq/README.md)
- [install curiel bot application](./roles/install_curiel_bot/README.md)
