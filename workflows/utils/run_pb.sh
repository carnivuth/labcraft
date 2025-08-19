#!/bin/bash

# function to execute a playbook with default parameters, this function needs to be executed in the ansible dir
function run_pb(){
  pb=$1
  shift
  if [[ ! -f "playbooks/$pb.yml" ]]; then
    echo "no $pb playbook found" | tee -a "$LOG_DIR/$pb.log"
  else
    if [[ $(git branch --show-current) == "develop" ]]; then test_limit="-l test"; fi
    source ../env/bin/activate
    ansible-playbook -i inventory/inventory.proxmox.yml "playbooks/$pb.yml" $test_limit $@ | tee -a "$LOG_DIR/$pb.log"
  fi
}
