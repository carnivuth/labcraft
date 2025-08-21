# Installation

Installation of the repository is done by cloning it inside the proxmox host and making an initial setup to allow the continous integration pipeline to trigger itself when commits are made to the main branch

- clone repository inside the proxmox host

```bash
git clone https://github.com/carnivuth/labcraft /usr/local/labcraft
```

- create a python virtual environment to run ansible inside and install ansible roles and collections

```bash
cd /usr/local/labcraft
python -m venv env
source env/bin/activate
pip install -r requirements.txt
ansible-galaxy collection install -r collections/requirements.yml
ansible-galaxy role install -r roles/requirements.yml
```

- add secrets folowing this [guide](#HANDLE%20SECRETS)

- create terraform vars file following the vars declaration in `terraform/variables.tf`

- create a proxmox admin token for terraform

- create templates for vms and containers

- install terraform

```bash
apt install terraform
```

- run terraform to deploy vms

```bash
cd terraform && terraform init && terraform plan -o /tmp/plan && terraform apply /tmp/plan
```

### Handle secrets

Sensitive informations are stored inside an encrypted vault file generated with `ansible-vault`, in order to create it do the following:

- create a  sample with the following command:

```bash
grep -e 'vault_[a-z_]*' playbooks/group_vars/all/vars.yml inventory/inventory.proxmox.yml  -ho > sample.yml
```

- create a file to store the vault password

```bash
pwgen -N 1 64 > passfile && chmod 600 passfile
```

- set vault pass file in `ansible.cfg`

```bash
[defaults]
host_key_checking = False
vault_password_file=/usr/local/labcraft/passfile
```

- add variables and encrypt the file with ansible vault

```bash
ansible-vault encrypt sample.yml
```

- move the file to the `group_vars` folder

```bash
mv sample.yml playbooks/group_vars/all/vault.yml
```

### Update management and provision

To avoid having to run ansible manually every time there is an update do the following

- add the `scripts/update_labcraft.sh` to cron:

```cron
# path variable is needed
PATH=/usr/local/labcraft/env/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
* * * * * /usr/local/labcraft/update_labcraft.sh > /dev/null 2>&1
```

Then link `workflows/middleware.sh` to the git hooks dir (*more on the topic [here](https://carnivuth.github.io/TIL/pages/git_github/GIT_HOOKS)*) as follows

```bash
cd .git/hooks
ln -fs ../../workflows/middleware.sh post-merge
```

So every time a commit is pushed to remote cron will pull the updates from remote repo and the git hook will run the correct workflow based on the file that was modified

```mermaid
---
title: UPDATE WORKFLOW
---
sequenceDiagram
participant dev_machine
participant github_repo
participant torterra

dev_machine ->> github_repo: push chainges
loop every x minutes
torterra ->> github_repo: fetch changes
alt changes
torterra ->> torterra: run middleware
torterra ->> torterra: run workflow based on the file that was modified
end
end
```
