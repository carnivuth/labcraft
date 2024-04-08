if [[ "$(systemctl status minecraft | grep active )" != '' ]]; then
 echo 'server is active, stop server with systemctl stop minecraft and rerun' && exit 1 
fi


# default variables
MINECRAFT_FOLDER='/usr/local/minecraft'
MINECRAFT_BACKUP_FOLDER='/usr/local'

# get minecraft download url
latest_version_url="$(curl -s 'https://launchermeta.mojang.com/mc/game/version_manifest.json' | jq -r  '.versions[0].url')"
latest_version_server_url="$(curl -s "$latest_version_url" | jq -r  '.downloads.server.url')"
latest_version="$(curl -s 'https://launchermeta.mojang.com/mc/game/version_manifest.json' | jq -r  '.versions[0].id')"

# create server backup
echo "creating backup in $MINECRAFT_BACKUP_FOLDER"
tar -cvf "$MINECRAFT_BACKUP_FOLDER/minecraft.server.backup.$(date -I).tar.gz" "$MINECRAFT_FOLDER"

# download new jar
echo "downloading new version from $latest_version_server_url"
curl -s "$latest_version_server_url" -o "$MINECRAFT_FOLDER/server.jar"

# setting permissions
chmod 700 server.jar
chown minecraft server.jar
