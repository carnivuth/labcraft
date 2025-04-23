#!/bin/bash
changes="$(git diff-tree --name-only -r HEAD@{1} HEAD)"
source env/bin/activate

# install python modules and ansible content
pip install -r requirements.txt
ansible-galaxy collection install -r collections/requirements.yml
ansible-galaxy role install -r roles/requirements.yml

for workflow in workflows/*; do
  if [[ "$workflow" != 'workflows/middleware.sh' ]];then
  (
    source "$workflow" && \
    regex="$(get_workflow_regex)"
    if  echo "$changes" | grep -q $regex; then
      echo "executing $workflow"
      output=$(workflow)
      echo -e "Subject: workflow $( basename "$workflow") LOG\n\n $output" | sendmail root
    fi
  )
  fi
done

