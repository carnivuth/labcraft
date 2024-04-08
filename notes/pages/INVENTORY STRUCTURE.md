an example of inventory can be found [here](https://github.com/carnivuth/homelab/blob/main/inventory/testing.yaml)

the project is develop with the idea that the only file you have to edit in order to use the playbooks it's the inventory, setting hosts in groups as you like 

each playbook run task against a specific group of hosts for example:

```yaml
- hosts: docker_hosts
  roles:
	- common
	- install_docker
```

will match the hosts you put in:

```yaml
## MACHINES WITH DOCKER RUNTIME SUPPORT
docker_hosts:
	hosts:
		wailhost:
		storax:
	vars:
		docker_users:
		 - #some user that need to run docker commands

```

