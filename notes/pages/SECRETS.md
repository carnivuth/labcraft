secrets are managed trough [ansible-vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html) with an interactive script called `create-vault.sh` that reads secrets defined in `secrets.txt` and create a file `vaults/vault.yaml` with the encrypted variables

## USAGE

just run the script in the project root 