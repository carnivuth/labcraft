role for dns masq server installation and configuration

the role:

- installs dnsmasq

- add every host under `all:` group in the dns 

- add the line `nameserver {{ dns_server }}` in every host defined in `all:` group
	
	`{{ dns_server }}` is an ansible variable defined in the [inventory](INVENTORY%20STRUCTURE.md) 

the role is designed to not mess around with dhcp setup configuration (it could be a host that can't be configured ) and to require minimal configuration to work `you just need to set  {{ dns_server }} ` variable