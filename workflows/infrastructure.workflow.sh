#!/bin/bash
# this workflow updates the infrastructure when there is a terraform update:
# - runs terraform
# - reconfigure dns (in case a new machine has been created)
# - exec basic configurations
# - configures mail notifications

source "workflows/utils/run_pb.sh"

LOG_DIR="/var/log/labcraft"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

function workflow(){

  # run terraform only in the main branch
  if [[ $(git branch --show-current) == "main" ]]; then
    (
      cd terraform
      timestamp="$(date +%s)"
      terraform plan -out "$LOG_DIR/terraform.$timestamp.plan.log" | tee -a "$LOG_DIR/terraform.log" && \
      terraform apply -auto-approve "$LOG_DIR/terraform.$timestamp.plan.log" | tee -a "$LOG_DIR/terraform.log"
    )
  fi

  # reconfigure dns
   ( cd ansible; run_pb dns; run_pb common; run_pb postfix)
}

function get_workflow_regex(){
  echo "terraform"
}
