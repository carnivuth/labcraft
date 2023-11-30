#!/bin/bash
VAULT_FOLDER=vaults
VAULT_FILE=vault.yaml

# create vault folder if does not exist
if [[ -d "$VAULT_FOLDER" ]]; then
  mkdir -p "$VAULT_FOLDER"
fi

# create vault file if does not exist
if [[ ! -f "$VAULT_FOLDER/$VAULT_FILE" ]]; then
  echo '' >"$VAULT_FOLDER/$VAULT_FILE"
fi

## server key generation
echo 'Creating wireguard server keys'
server_private_key="$(wg genkey)"
server_public_key="$(echo $server_private_key | wg pubkey)"
echo $server_private_key >vaults/wireguard_server_private.key
echo $server_public_key >vaults/wireguard_server_public.key

## client key generation
echo 'Creating wireguard peer keys'
peer_private_key="$(wg genkey)"
peer_public_key="$(echo $peer_private_key | wg pubkey)"
echo $peer_private_key >vaults/wireguard_peer_private.key
echo $peer_public_key >vaults/wireguard_peer_public.key

# ask vault password
echo input vault password, it will be used for unlock the vault at runtime
read -s vault_pwd
echo $vault_pwd >"$VAULT_FOLDER/pwd.secret"

## add keys to the ansible vault file
ansible-vault encrypt_string "$(cat vaults/wireguard_peer_private.key)" --name "wireguard_peer_private_key" --vault-password-file "$VAULT_FOLDER/pwd.secret" >>"$VAULT_FOLDER/$VAULT_FILE"
ansible-vault encrypt_string "$(cat vaults/wireguard_peer_public.key)" --name "wireguard_peer_public_key" --vault-password-file "$VAULT_FOLDER/pwd.secret" >>"$VAULT_FOLDER/$VAULT_FILE"
ansible-vault encrypt_string "$(cat vaults/wireguard_server_private.key)" --name "wireguard_server_private_key" --vault-password-file "$VAULT_FOLDER/pwd.secret" >>"$VAULT_FOLDER/$VAULT_FILE"
ansible-vault encrypt_string "$(cat vaults/wireguard_server_public.key)" --name "wireguard_server_public_key" --vault-password-file "$VAULT_FOLDER/pwd.secret" >>"$VAULT_FOLDER/$VAULT_FILE"

# remove vault pass file
rm "$VAULT_FOLDER/pwd.secret"
