# Labcraft

Infrastructure as code definition for my proxmox virtual environment instance.

## Why this

The goal of this project is to create menage my personal proxmox instance in a git ops way with declarative infrastructure and configurations, to achieve this goal the following tech stack is deployed inside the project:

- [terraform](https://developer.hashicorp.com/terraform) to provision qemu managed virtual machines and LXC containers
- [docker](https://www.docker.com/) to manage services for personal use.
- [ansible](docs.ansible.com/ansible/latest/index.html) to automate provisioning operations
- [git](https://git-scm.com/) to version the infrastructure state
- bash scripting for utilities and workflows

## Features

- Auto update with email notifications of docker machines with applications
- Auto provisioning of vm and containers with DNS already configured and other basic utilities
- Deployment of docker compose sets of services

## Concepts and problem modeling

Refer to the [basic concepts page](doc/concepts.md)

## Installation

Refer to the [installation page](doc/installation.md)

## Create new contariner/virtual machine

Refer to the [infrastrucure page](doc/infrastructure.md)

## Backup management

Refer to the [backup page](doc/backup.md)

## Deploy new docker services

Refer to the [new docker service deployment page](doc/docker_service.md)

