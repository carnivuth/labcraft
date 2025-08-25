#!/bin/bash
# this workflow updates the infrastructure when there is a terraform update:
# - runs terraform
# - reconfigure dns (in case a new machine has been created)
# - exec basic configurations
# - configures mail notifications

source "workflows/utils/run_pb.sh"

LOG_DIR="/var/log/labcraft"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

function workflow(){

  changes="$1"
  # run terraform only in the main branch
  if [[ $(git branch --show-current) == "main" ]]; then
    (
      cd infrastructure/IaC
      timestamp="$(date +%s)"
      terraform plan -out "$LOG_DIR/terraform.$timestamp.plan.log" | tee -a "$LOG_DIR/terraform.log" && \
      terraform apply -auto-approve "$LOG_DIR/terraform.$timestamp.plan.log" | tee -a "$LOG_DIR/terraform.log"
    )
  fi

  # reconfigure dns after terraform runs and apply common configurations to hosts an postfix setup
   ( cd infrastructure; run_pb dns; run_pb common; run_pb postfix)

   # install docker engine when a new service provider is created
   grep -q "docker" "$changes" && (cd infrastructure; run_pb docker )

}

function get_workflow_regex(){
  echo "infrastructure"
}
