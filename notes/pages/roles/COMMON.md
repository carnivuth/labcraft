role for common machine setup

the role make some utility configuration on target machines:

- install some utility packages 
- copy some default file configurations
- create a default user with sudo privileges
- copy ssh keys

## ADMIN USER

the role creates a default admin user with parameters defined in the [inventory](INVENTORY%20STRUCTURE.md) 

### `admin_password`

this parameter is treated as a [secret](SECRETS.md)

