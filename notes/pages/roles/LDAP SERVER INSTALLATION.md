role for LDAP server installation and configuration

the role installs slapd daemon and configure it with debconf

## CONFIGURATION

ldap domain, password and organization can be set trough variables
in the [inventory](INVENTORY%20STRUCTURE.md) 

```yaml
address: # ldap server address
organization: # ldap organization
dc: # ldap dc
pwd: # ldap password
```

there is also an [ansible role](LDAP%20SERVER%20USERS%20SETUP.md) to add users and groups to the server