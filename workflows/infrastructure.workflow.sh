#!/bin/bash
# this workflow updates the infrastructure when there is a opentofu update:
# - runs opentofu
# - reconfigure dns (in case a new machine has been created)
# - exec basic configurations
# - configures mail notifications

source "workflows/utils/run_pb.sh"

LOG_DIR="/var/log/labcraft"; if [[ ! -d "$LOG_DIR" ]];then mkdir -p "$LOG_DIR"; fi

function workflow(){

  changes="$1"
  # run opentofu only in the main branch
  if [[ $(git branch --show-current) == "main" ]]; then
    (
      cd infrastructure/IaC
      timestamp="$(date +%s)"
      #tofu plan -out "$LOG_DIR/tofu.$timestamp.plan.log" | tee -a "$LOG_DIR/opentofu.log" && \
      #tofy apply -auto-approve "$LOG_DIR/tofu.$timestamp.plan.log" | tee -a "$LOG_DIR/opentofu.log"
    )
  fi

  # reconfigure dns after opentofu runs and apply common configurations to hosts an postfix setup
   ( cd infrastructure; run_pb dns; run_pb common; run_pb postfix)

   # install docker engine when a new docker host is created
   grep -q "docker" $changes && (cd infrastructure; run_pb docker )

   # install vpn server when a vpn endpoint is created
   grep -q "vpn" $changes && (cd infrastructure; run_pb vpn )

}

function get_workflow_regex(){
  echo "infrastructure"
}
