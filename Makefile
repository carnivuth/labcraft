SHELL=/bin/bash
.PHONY: playbooks/* playbooks/files/services/* services install /var/spool/cron/crontabs/$(USER) update

inventory_opt = -i inventory/inventory.proxmox.yml
ifdef inventory
inventory_opt = -i $(inventory)
endif

ifdef user
user_opt = -u $(user)
endif

ifdef key
key_opt = --private-key $(key)
endif

.git/hooks/post-merge:
	echo -e '#!/bin/bash\nmake update' > $@
	chmod +x "$@"

env: requirements.txt
	python -m venv env && source env/bin/activate && pip install -r requirements.txt

~/.ansible/collections/ansible_collections/: requirements.yml
	source env/bin/activate && ansible-galaxy install -r requirements.yml

inventory/group_vars/all/vault.yml:
	mkdir -p $$(dirname $@)
	grep -ho -e 'vault_[a-z_]*' $$(find  inventory playbooks -name '*.yml' | grep -v vault.yml) | sort -u > $@

playbooks/*: env ~/.ansible/collections/ansible_collections/
	source env/bin/activate && ansible-playbook $(inventory_opt) $@ -e app=$$(basename $@) $(user_opt) $(key_opt) $(opts)

playbooks/files/services/*: env ~/.ansible/collections/ansible_collections/
	source env/bin/activate && ansible-playbook $(inventory_opt) playbooks/service.yml  -e app=$$(basename $@) $(user_opt) $(key_opt) $(opts)

/var/spool/cron/crontabs/$(USER):
	(crontab -l 2>/dev/null; crontab -l | grep -q "cd $$(pwd) && git pull > /dev/null 2>&1" || echo "* * * * * cd $$(pwd) && git pull > /dev/null 2>&1") | crontab -

services: playbooks/files/services/*

install: env ~/.ansible/collections/ansible_collections/ .git/hooks/post-merge playbooks/setup_proxmox.yml playbooks/common.yml playbooks/align_cloudflare_dns.yml playbooks/postfix.yml services

update: env ~/.ansible/collections/ansible_collections/ .git/hooks/post-merge playbooks/setup_proxmox.yml playbooks/common.yml playbooks/align_cloudflare_dns.yml
	git diff-tree --name-only -r HEAD@{1} HEAD | grep files/services/ | cut -d'/' -f1,2,3,4 | parallel make {}
