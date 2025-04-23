#!/bin/bash
changes="$(git diff-tree --name-only -r HEAD@{1} HEAD)"

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

