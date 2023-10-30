role for insert ldap entries for user login

- insert ldap group and people entry
- add users configured in vars file, vars file must be as follow

```yaml
users:

	#insert uid value
	- dn: uid= ,ou=People,dc="{{ dc }}"
	givenName: #insert name
	cn: #insert cn
	sn: #insert surname
	mail: #insert email
	uid: #insert uid
	uidNumber: #insert uidnumber
	gidNumber: #insert gidnumber
	homeDirectory: #insert home path
	loginShell: #insert login shell
	gecos: #insert gecos
	userPassword: "{crypt}x"

userspassword:
	- uid: #insert name
	passwd: #insert pwd

usergroups:
	- cn: #insert group name
	gidNumber: 10000
```