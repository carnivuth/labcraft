#!/bin/bash
# this workflow updates the state of the docker service manager host, based on the state of the docker compose files, it
# - detects the modified compose files
# - runs the playbook to update the docker host accordingly

source "$(basedir "$0")/utils/run_pb.sh"

LOG_DIR="/var/log/labcraft"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

function workflow(){

  for file in $0; do
     (cd ansible && run_pb deploy_service -e app="$(dirname "$file")")
  done

}

function get_workflow_regex(){
  echo "services"
}
