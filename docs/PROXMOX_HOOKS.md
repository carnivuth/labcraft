# PROXMOX HOOKS SCRIPT

Scripts are runned in multiple moments of the ct/vm lifecicle, they can be of different types (*e.g. bash perl python*) they run inside the proxmox host.

they are called as `scriptname <vmid> <phase>` where

- vmid is the id of the container/vm
- phase is a string that refers the lifecicle hook, can have 4 values: `pre-start post-start pre-stop post-stop`

they must reside under `/var/lib/vz/snippets/`

template for a bash hook:

```bash
#!/bin/bash

DEPS=""
LOG_FILE="/var/log/filename.log"

vmid=$1
shift
vmid=$1

if [[ "$phase" == 'pre-start' ]]; then
fi

if [[ "$phase" == 'post-start' ]]; then
fi

if [[ "$phase" == 'pre-stop' ]]; then
fi

if [[ "$phase" == 'post-start' ]]; then
fi
```
