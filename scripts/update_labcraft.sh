#!/bin/bash
LOG_DIR="/var/log"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

cd /usr/local/labcraft
output="$(git pull)"
if echo "$output" | grep -E 'Aborted' >> "$LOG_DIR/$(basename "$0").log"; then
        echo -e "Subject: $(basename $0) LOG\n\nthere are conflicts in repo" | sendmail  root
fi
