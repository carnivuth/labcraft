```yaml
## section for ldap server machine
LDAP_server:
	hosts:
		castleterra:
			# ldap server parameters
			address: 192.168.0.2 
			dc: homelab.local
			pwd: pippo

## section for ldap client machines
LDAP_clients:
	hosts:
		castleterra:
		#ldap server parameters
		address: 192.168.0.2
		dc: homelab.local
		pwd: pippo
		.........
  
## MACHINES WITH DOCKER RUNTIME SUPPORT
docker_hosts:
	hosts:
		wailhost:
		storax:
	vars:
		docker_users:
		 - #some user that need to run docker commands

## MACHINES WITH PORTAINER
portainer_dashboard_host:
	hosts:
		wailhost:

portainer_agent_hosts:
	hosts:
		storax:

  

# MACHINE WITH HOMER DASHBOARD
dashboard_host:
	hosts:
		wailhost:

  

# NAS SERVER HOST
nas_server:
	hosts:
		storax:

all:
	hosts:
		castleterra:
			ansible_user: vagrant
					ansible_ssh_private_key_file: staging/castleterra/.vagrant/machines/default/virtualbox/private_key

			ansible_host: 127.0.0.1
			
			ansible_port: 2222

			ansible_hostname: castleterra

  

		storax:

			ansible_user: vagrant
			
			ansible_ssh_private_key_file: staging/storax/.vagrant/machines/default/virtualbox/private_key
			
			ansible_host: 127.0.0.1
			
			ansible_port: 2223
			
			ansible_hostname: storax
			
  

		wailhost:

			ansible_user: vagrant
			
			ansible_ssh_private_key_file: staging/wailhost/.vagrant/machines/default/virtualbox/private_key
			
			ansible_host: 127.0.0.1
			
			ansible_port: 2224
			
			ansible_hostname: wailhost
```