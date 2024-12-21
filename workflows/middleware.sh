#!/bin/bash
changes="$(git diff-tree --name-only -r HEAD@{1} HEAD)"

for workflow in workflows/*; do
  if [[ "$workflow" != 'workflows/middleware.sh' ]];then
  (
    source "$workflow" && \
    regex="$(get_workflow_regex)" &&\
    echo "$changes" | grep -q $regex && \
    echo "executing $workflow" && \
    workflow
  )
  fi
done

