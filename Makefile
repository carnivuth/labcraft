.PHONY: deps playbooks/*

env: requirements.txt
	python -m venv env && source env/bin/activate && pip install -r requirements.txt

deps: requirements.yml
	source env/bin/activate && ansible-galaxy install -r requirements.yml

inventory/group_vars/all/vault.yml:
	grep -ho -e 'vault_[a-z_]*' $$(find  inventory playbooks -name '*.yml' | grep -v vault.yml) | sort -u > $@

playbooks/*:
	ansible-playbook -i inventory/inventory.proxmox.yml $@

