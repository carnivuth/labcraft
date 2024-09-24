# LABCRAFT

Files for homelab provisioning and maintenance operations of my personal proxmox cluster for self-hosted services, application deployment environment and playhouse :)

## ARCHITECTURE

The machine runs proxmox cluster with vm's and container above it

```mermaid
flowchart LR
subgraph pokelab
direction TB
A[castleterra\n the proxmox host]
B[wailord\n docker host for self-hosted services]
C[espeon\n dns server]
D[umbreon \n second dns server]
E[staraptor\n web server for external reverse proxy]
G[arcanine\n wireguard host]
I[dittup\n pbs host for backups]
A --> B & C & D & E & G & I
end
```

## NETWORKING

some services are exposed to the internet via HTTPS reverse proxy with nginx

```mermaid
flowchart LR
A((Internet))
B{starweb}
C[nextcloud]
D[gitlab]
E[jenkins]
C & D & E --> B
B --> A
```

some other services are exposed through port forwarding on the router

```mermaid
flowchart LR
A((Internet))
B{router\n port forwarding}
C[minecraft]
D[xonotic]
E[wireguard]
C & D & E --> B
B --> A
```

## DISKS MANAGEMENT

Containers and virtual machines's rootfs disk is located in the `local-lvm` volume on the nvme disk. all the volumes are backuped in the other hard drive from pbs

```mermaid
flowchart
	subgraph data disks
		direction TB
		subgraph nvme
				A[container rootfs]
		end
		subgraph HD1
			B[container external storage]
		end
	end
	subgraph backupdisks
		direction TB
		subgraph HD2
			direction LR
			C[backup volume]
		end
	end
	A & B -- backup on --> C
	A   -- mounted on /mnt/storage --> B
```

## BACKUPS

Backups are made with the use of PBS in snapshot mode, every night at 21:00 for all containers and virtual machines, one of the 2 hard drives is dedicated to this purpose, only the last 5 backups are maintained

for big containers stop mode is used instead, see [this](https://pve.proxmox.com/wiki/Backup_and_Restore#_backup_modes) for reference

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

- create vars file following the template in `vars/sample.yml`

```bash
cp playbooks/vars/sample.yml playbooks/vars/prod.yml
```

- create terraform vars file following the vars declaration in `terraform/variables.tf`

- create a proxmox admin token for terraform

- create templates for vms and containers following [this](https://carnivuth.github.io/TIL/pages/CREATE_VM_TEMPLATE)

- run terraform to deploy vms and add one of the dns servers to `/etc/hosts`

- run preflight playbook for provisioning

```bash
ansible-playbook -i inventory/prod.proxmox.yml carnivuth.labcraft.preflight
```
