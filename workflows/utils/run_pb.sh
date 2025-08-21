#!/bin/bash

# function to execute a playbook with default parameters, this function needs to be executed in the ansible dir
function run_pb(){
  pb=$1
  shift
  if [[ ! -f "$pb.playbook.yml" ]]; then
    echo "no $pb playbook found" | tee -a "$LOG_DIR/$pb.log"
  else
    ansible-playbook -i inventory/inventory.proxmox.yml "playbooks/$pb.playbook.yml" $@ | tee -a "$LOG_DIR/$pb.playbook.log"
  fi
}
