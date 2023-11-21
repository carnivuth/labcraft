#!/bin/bash
VAULT_FOLDER=vaults
VAULT_FILE=vault.yaml
echo 'interactive script for ansible vault creation'

if [[ -d "$VAULT_FOLDER" ]]; then 
    mkdir -p "$VAULT_FOLDER"
fi

echo '' > "$VAULT_FOLDER/$VAULT_FILE"
echo input vault password, it will be used for unlock the vault at runtime
read -s vault_pwd
echo $vault_pwd > "$VAULT_FOLDER/pwd.secret"
  while read name desc <&3; do
    echo "insert secret $name $desc"
    read  -s value 
    ansible-vault encrypt_string  "$value" --name "$name" --vault-password-file  "$VAULT_FOLDER/pwd.secret" >> "$VAULT_FOLDER/$VAULT_FILE"
    echo $'\n' >> "$VAULT_FOLDER/$VAULT_FILE"
done 3<secrets.txt

rm "$VAULT_FOLDER/pwd.secret"

