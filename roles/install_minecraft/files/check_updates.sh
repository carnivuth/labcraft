MINECRAFT_FOLDER='/usr/local/minecraft'
latest_version="$(curl -s 'https://launchermeta.mojang.com/mc/game/version_manifest.json' | jq -r  '.versions[0].id')"
if [[ "$(ls $MINECRAFT_FOLDER/versions | grep $latest_version)" == '' ]]; then
    echo 'server da aggiornare'
else
    echo 'server aggiornato'
fi

