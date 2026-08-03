SHELL=/bin/bash
.PHONY: playbooks/* install /var/spool/cron/crontabs/$(USER)

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

inventory/group_vars/all/vault.yml: playbooks inventory
	mkdir -p $$(dirname $@)
	touch  $@
	grep -rho -e 'vault_[a-z_]*' inventory playbooks | sort -u | parallel 'grep -q {} $@ || echo {}:' >> $@

playbooks/roles/align_services/files/%:
	mkdir -p '$@'
	touch '$@/docker-compose.yml'
	echo -e "PUID_$$(echo $@ | awk -F'/' '{print $$5 }'| tr '[:lower:]' '[:upper:]')={{ container_puid }}\nPGID_$$(echo $@ | awk -F'/' '{print $$5 }' | tr '[:lower:]' '[:upper:]')={{ container_pgid }}\nPGID_SERVICES={{ services_pgid }}\nHOST={{ container_host }}" > '$@/env.j2'


playbooks/roles/*: env ~/.ansible/collections/ansible_collections/
	source env/bin/activate && ansible-galaxy role init $@

playbooks/*: env ~/.ansible/collections/ansible_collections/
	source env/bin/activate && ansible-playbook $(inventory_opt) $@ $(user_opt) $(key_opt) $(opts)

/var/spool/cron/crontabs/$(USER):
	(crontab -l 2>/dev/null; crontab -l | grep -q "cd $$(pwd) && git pull > /dev/null 2>&1" || echo "* * * * * cd $$(pwd) && git pull > /dev/null 2>&1") | crontab -

install: env ansible.cfg ~/.ansible/collections/ansible_collections/ .git/hooks/post-merge playbooks/site.yml

roles_toc.md: playbooks/roles/**/README.md playbooks/roles/**/meta/main.yml
	find playbooks/roles -type f -name README.md | sort -u | parallel 'echo -e "# [$$( basename $$( dirname {} ) )]({})\n\n- author: $$(yq .galaxy_info.author $$( dirname {} )/meta/main.yml)\n\n$$(yq .galaxy_info.description $$( dirname {} )/meta/main.yml)\n"' > $@
