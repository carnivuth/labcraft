#!/bin/bash
# this workflow creates a new docker container on the provisioner:
# - runs terraform
# - reconfigure dns (in case a new machine has been created)
# - runs common configurations

 LOG_DIR="/var/log/labcraft"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

function run_pb(){
  if [[ ! -f "playbooks/$1.yml" ]]; then
    echo "no $1 playbook found" >> "$LOG_DIR/common.log"
  else
    source env/bin/activate
    ansible-playbook -i inventory/inventory.proxmox.yml "playbooks/$1.yml" >> "$LOG_DIR/$1.log"
  fi
}

function workflow(){

  # run service manager
  run_pb service_manager
}
function get_workflow_regex(){
  echo "*compose*"
}
