SHELL=/bin/bash
.PHONY: playbooks/* playbooks/files/services/* services install /var/spool/cron/crontabs/$(USER) update playbooks/roles/*

inventory_opt = -i inventory/carnivuth.org.yml
ifdef inventory
inventory_opt = -i $(inventory)
endif

ifdef user
user_opt = -u $(user)
endif

ifdef key
key_opt = --private-key $(key)
endif

ansible.cfg:
	echo -e '[defaults]\nstdout_callback = telegram\ncallback_whitelist = telegram' > $@

.git/hooks/post-merge:
	echo -e '#!/bin/bash\nmake install' > $@
	chmod +x "$@"

env: requirements.txt
	python -m venv env && source env/bin/activate && pip install -r requirements.txt

~/.ansible/collections/ansible_collections/: requirements.yml env
	source env/bin/activate && ansible-galaxy install -r requirements.yml

inventory/group_vars/all/vault.yml:
	mkdir -p $$(dirname $@)
	grep -ho -e 'vault_[a-z_]*' $$(find  inventory playbooks -name '*.yml' | grep -v vault.yml) | sort -u > $@

playbooks/roles/%: env ~/.ansible/collections/ansible_collections/
	source env/bin/activate && ansible-galaxy role init $@

playbooks/*: env ~/.ansible/collections/ansible_collections/
	source env/bin/activate && ansible-playbook $(inventory_opt) $@ $(user_opt) $(key_opt) $(opts)

/var/spool/cron/crontabs/$(USER):
	(crontab -l 2>/dev/null; crontab -l | grep -q "cd $$(pwd) && git pull > /dev/null 2>&1" || echo "* * * * * cd $$(pwd) && git pull > /dev/null 2>&1") | crontab -

install: env ansible.cfg ~/.ansible/collections/ansible_collections/ .git/hooks/post-merge playbooks/site.yml
