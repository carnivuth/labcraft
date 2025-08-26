#!/bin/bash
# this workflow updates the state of the docker service manager host, based on the state of the docker compose files, it
# - detects the modified compose files
# - runs the playbook to update the docker host accordingly

source "workflows/utils/run_pb.sh"

LOG_DIR="/var/log/labcraft"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

function workflow(){

  for file in $@; do
    app="$( echo "$file" | awk -F'/' '{print $3}')"
    case "$file" in
      *docker-compose.yml )
        echo "execute deploy_service playbook with -e app=$app parameter"
        (cd services && run_pb service -e app="$app")
        ;;
      inventory|group_vars )
        for df in $(find services -name 'docker-compose.yml'); do
          echo "execute deploy_service playbook with -e app=$app parameter"
          (cd services && run_pb service -e app="$app")
        done
        ;;
    esac
  done

}

function get_workflow_regex(){
  echo "services"
}
