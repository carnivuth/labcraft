# Backups management

This infrastructure manages all of my backups, the backup centralizer is an lxc container that runs [pbs](https://www.proxmox.com/en/products/proxmox-backup-server/overview)

```mermaid
flowchart
    subgraph ditto
		subgraph data_volume_group
        A[rootfs]
		end
		subgraph backup_volume_group
        B[backup disk]
		end
    end
```

All of my personal pc use borg for managing backup locally and then copy content to the centralizer machine using rsync, backup is achieved trough a [script](https://github.com/carnivuth/scripts/blob/main/bin/backup.sh) that runs as a systemd timer

```mermaid
sequenceDiagram
participant laptop
participant ditto
laptop ->> laptop: creates backup
laptop ->> ditto: sync changes
Note over laptop,ditto: connection secured trough vpn
```

vms and containers backups are managed trough proxmox backup server installed on the centralizer
