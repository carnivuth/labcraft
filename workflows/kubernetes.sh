#!/bin/bash
# this workflow runs kubernetes cluster provisioning when a kube cluster is modified:
# - runs terraform
# - reconfigure dns (in case a new machine has been created)
# - runs common configurations

 LOG_DIR="/var/log/labcraft"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

function run_pb(){
  if [[ ! -f "playbooks/$1.yml" ]]; then
    echo "no $1 playbook found" | tee -a "$LOG_DIR/$1.log"
  else
    source env/bin/activate
    ansible-playbook -i inventory/inventory.proxmox.yml "playbooks/$1.yml" | tee -a "$LOG_DIR/$1.log"
  fi
}

function workflow(){

  cd terraform
  timestamp="$(date +%s)"
  terraform plan -out "$LOG_DIR/terraform.$timestamp.plan.log" | tee -a "$LOG_DIR/terraform.log" && terraform apply -auto-approve "$LOG_DIR/terraform.$timestamp.plan.log" | tee -a "$LOG_DIR/terraform.log"

  # reconfigure dns
  cd .. && (run_pb kubernetes;)
}

function get_workflow_regex(){
  echo "kubernetes"
}
