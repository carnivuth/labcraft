role for samba configuration and setup

- install samba server packages 
- copy samba configuration from template 

the configuration template use the following variables defined in the inventory

```yaml

# public share folder path
public_folder_path: /home/shares/public

# workgroup
samba_workgroup: homelab

# force group parameter
public_group: public

# samba configuration block name
public_folder: public

```

- create `public_folder_path`  folder
- create `public_group`  group
- restart samba service