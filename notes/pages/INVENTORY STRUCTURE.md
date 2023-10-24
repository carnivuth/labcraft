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
  
## section for docker installation target
docker_host:
	hosts:
		wailhost:

## section for dashboard installation target
dashboard_host:
	hosts:
		wailhost:
		
## section
for docker installation target
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