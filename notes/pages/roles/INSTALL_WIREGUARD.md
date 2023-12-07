role for wireguard configuration and setup

the role installs wireguard service on the targets, sets a basic firewall configuration with `ufw` and `iptables` to allow traffic for the vpn, and start the service

## SECRETS MANAGEMENT

wireguard keys are managed separately from the other vault secrets, there is a script [`create_wireguard_key.sh`](https://github.com/carnivuth/homelab/blob/main/create_wireguard_key.sh) that creates the private and public peer and server keys which are then encrypted and included in the ansible vault file

the keys are also saved under the `$VAULT_FOLDER` directory to simplify the client configuration 

there are also other wireguard parameters managed with the main script, see [secrets management](SECRETS.md) for reference