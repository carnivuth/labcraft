#!/bin/bash
# this workflow updates the state of the docker service manager host, based on the state of the docker compose files, it
# - detects the modified compose files
# - runs the playbook to update the docker host accordingly

 LOG_DIR="/var/log/labcraft"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

function run_pb(){
  pb=$1
  shift
  if [[ ! -f "ansible/playbooks/$pb.yml" ]]; then
    echo "no $pb playbook found" | tee -a "$LOG_DIR/$pb.log"
  else
    source env/bin/activate
    ansible-playbook -i ansible/inventory/inventory.proxmox.yml "ansible/playbooks/$pb.yml" "$@" | tee -a "$LOG_DIR/$1.log"
  fi
}

function workflow(){

  for file in $0; do
    (run_pb deploy_service -e app="$(dirname "$file")")
  done

}

function get_workflow_regex(){
  echo "services"
}
