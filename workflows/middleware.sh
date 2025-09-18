#!/bin/bash
changes="$(git diff-tree --name-only -r HEAD@{1} HEAD)"
source env/bin/activate

# install python modules and ansible content
pip install -r requirements.txt
ansible-galaxy install -r requirements.yml

for workflow in $(find workflows -name '*.workflow.sh'); do
  (
    source "$workflow" && \
    regex="$(get_workflow_regex)"
    if  echo "$changes" | grep -v workflows | grep -q $regex; then
      echo "executing $workflow $changes"
      output=$(workflow $changes)
      echo -e "Subject: workflow $( basename "$workflow") LOG\n\n $output" | sendmail root
    fi
  )
done

