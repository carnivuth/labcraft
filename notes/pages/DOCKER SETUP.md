setup target for docker containers deployment 

- the playbook install `docker.io` from debian repositories

- install `docker-compose`
- add the `{{docker_user}}` to `docker` group to control docker without sudo
- reboot the machine (weird behavior due to system not rebooting, maybe due to some kernel modules? )

