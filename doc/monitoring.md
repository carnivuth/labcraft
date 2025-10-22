# Monitoring

Monitoring is done using [grafana](https://grafana.com/) (*both self hosted and cloud*) at 2 different levels:

- infrastructure level: monitors infrastructural components like proxmox hosts status, machine and vms
- service monitoring: monitors personal services information

```mermaid
flowchart LR
subgraph cloud
A@{shape: cloud, label: grafana cloud}
end
subgraph self-hosted
B@{shape: proc, label: grafana self hosted}
C@{shape: docs, label: services}
D@{shape: docs, label: proxmox hosts}
E@{shape: docs, label: containers and vms}
end
cloud ~~~ self-hosted

A -- monitors --> D & E
B -- monitors --> C
```
