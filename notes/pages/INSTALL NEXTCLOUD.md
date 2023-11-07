role for nextcloud installation

the role install nextcloud:fpm docker image and use docker secrets for sensitive informations 
## TASKS

the role:
- copies docker compose file on the remote host
- copy docker secrets on the remote host
- start nextcloud with docker compose

## SECRETS 

secrets must be created from the example files