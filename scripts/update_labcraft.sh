#!/bin/bash
NTFY_ADDRESS="https://pokelab.ddns.net/ntfy/homelab"
LOG_DIR="/var/log"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

cd /usr/local/labcraft
output="$(git pull)"
if echo "$output" | grep -E 'Aborted' >> "$LOG_DIR/$(basename "$0").log"; then
  curl  "$NTFY_ADDRESS" -d "there are conflicts in repo";
elif ! echo "$output" | grep -E 'Already up to date.' >> "$LOG_DIR/$(basename "$0").log"; then
  curl  "$NTFY_ADDRESS" -d "updated labcraft repo";
fi
