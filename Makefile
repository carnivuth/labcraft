SHELL=/bin/bash
.PHONY: playbooks/* playbooks/files/services/* services install /var/spool/cron/crontabs/$(USER)

.git/hooks/post-merge:
	echo -e '#!/bin/bash\nmake install' > $@
	chmod +x "$@"

env: requirements.txt
	python -m venv env && source env/bin/activate && pip install -r requirements.txt

~/.ansible/collections/ansible_collections/: requirements.yml
	source env/bin/activate && ansible-galaxy install -r requirements.yml

inventory/group_vars/all/vault.yml:
	mkdir -p $$(dirname $@)
	grep -ho -e 'vault_[a-z_]*' $$(find  inventory playbooks -name '*.yml' | grep -v vault.yml) | sort -u > $@

playbooks/*: env ~/.ansible/collections/ansible_collections/
	source env/bin/activate && \
	ansible-playbook -i inventory/inventory.proxmox.yml $@

playbooks/files/services/*: env ~/.ansible/collections/ansible_collections/
	source env/bin/activate && \
	ansible-playbook -i inventory/inventory.proxmox.yml playbooks/service.yml -e app=$$(basename $@)

/var/spool/cron/crontabs/$(USER):
	(crontab -l 2>/dev/null; crontab -l | grep -q "cd $$(pwd) && git pull 2>/dev/null" || echo "* * * * * cd $$(pwd) && git pull 2> /dev/null") | crontab -

services: playbooks/files/services/*

install: env ~/.ansible/collections/ansible_collections/ .git/hooks/post-merge playbooks/common.yml playbooks/align_cloudflare_dns.yml playbooks/postfix.yml services
