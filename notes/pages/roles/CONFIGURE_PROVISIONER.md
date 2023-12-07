role for provisioner machine setup

the role setups a machine to be the provisioner for the other machines

```
--------------
| provisioner |
--------------
		|
		| ansible-playbook
		|
	------------
	| target   |
	| machines |
	------------	
```


the role clones this repository on the machine and setups a cronjob for continuous updating

## CRONJOBS

the role set some playbooks to run as cronjobs such as:

- [common](COMMON.md)
