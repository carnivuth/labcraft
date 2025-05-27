# Control Plane
resource "proxmox_vm_qemu" "cp" {
  name        = "cp"
  tags        = "test,kubernetes_control_plane"
  pool        = "test"
  cores       = 4
  sockets     = 1
  memory      = 4192
  target_node = var.proxmox_host
  clone       = "ubuntu-2404-cloudinit-template"
  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.211/24"
  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0;net0"
  cipassword  = var.guest_password
  ciuser      = var.guest_user
  sshkeys     = var.ssh_pub_key
  nameserver  = var.nameserver
  onboot      = false
  vm_state    = "running"

  connection {
    type     = "ssh"
    user     = "root"
    password = var.guest_password
    host     = "192.168.1.211"
  }

  provisioner "remote-exec" {
    inline = [
    "apt-get update",
    "apt-get install -y apt-transport-https ca-certificates curl gpg containerd",
    "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg",
    "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list",
    "apt-get update",
    "apt-get install -y kubelet kubeadm kubectl",
    "apt-mark hold kubelet kubeadm kubectl",
    "systemctl enable --now kubelet",
    ]
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.main_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "50G"
          storage = var.main_pool
        }
      }
    }
  }
}

# Workers
resource "proxmox_vm_qemu" "worker1" {
  name        = "worker1"
  tags        = "test,kubernetes_worker"
  pool        = "test"
  cores       = 4
  sockets     = 1
  memory      = 8192
  target_node = var.proxmox_host
  clone       = "ubuntu-2404-cloudinit-template"
  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.212/24"
  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0;net0"
  cipassword  = var.guest_password
  ciuser      = var.guest_user
  sshkeys     = var.ssh_pub_key
  nameserver  = var.nameserver
  onboot      = false
  vm_state    = "running"

  connection {
    type     = "ssh"
    user     = "root"
    password = var.guest_password
    host     = "192.168.1.212"
  }

  provisioner "remote-exec" {
    inline = [
    "apt-get update",
    "apt-get install -y apt-transport-https ca-certificates curl gpg containerd",
    "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg",
    "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list",
    "apt-get update",
    "apt-get install -y kubelet kubeadm kubectl",
    "apt-mark hold kubelet kubeadm kubectl",
    "systemctl enable --now kubelet",
    ]
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.main_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "50G"
          storage = var.main_pool
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "worker2" {
  name        = "worker2"
  tags        = "test,kubernetes_worker"
  pool        = "test"
  cores       = 4
  sockets     = 1
  memory      = 8192
  target_node = var.proxmox_host
  clone       = "ubuntu-2404-cloudinit-template"
  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.213/24"
  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0;net0"
  cipassword  = var.guest_password
  ciuser      = var.guest_user
  sshkeys     = var.ssh_pub_key
  nameserver  = var.nameserver
  onboot      = false
  vm_state    = "running"

  connection {
    type     = "ssh"
    user     = "root"
    password = var.guest_password
    host     = "192.168.1.213"
  }

  provisioner "remote-exec" {
    inline = [
    "apt-get update",
    "apt-get install -y apt-transport-https ca-certificates curl gpg containerd",
    "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg",
    "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list",
    "apt-get update",
    "apt-get install -y kubelet kubeadm kubectl",
    "apt-mark hold kubelet kubeadm kubectl",
    "systemctl enable --now kubelet",
    ]
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.main_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "50G"
          storage = var.main_pool
        }
      }
    }
  }
}

resource "proxmox_vm_qemu" "worker3" {
  name        = "worker3"
  tags        = "test,kubernetes_worker"
  pool        = "test"
  cores       = 4
  sockets     = 1
  memory      = 8192
  target_node = var.proxmox_host
  clone       = "ubuntu-2404-cloudinit-template"
  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.214/24"
  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0;net0"
  cipassword  = var.guest_password
  ciuser      = var.guest_user
  sshkeys     = var.ssh_pub_key
  nameserver  = var.nameserver
  onboot      = false
  vm_state    = "running"

  connection {
    type     = "ssh"
    user     = "root"
    password = var.guest_password
    host     = "192.168.1.214"
  }

  provisioner "remote-exec" {
    inline = [
    "apt-get update",
    "apt-get install -y apt-transport-https ca-certificates curl gpg containerd",
    "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg",
    "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list",
    "apt-get update",
    "apt-get install -y kubelet kubeadm kubectl",
    "apt-mark hold kubelet kubeadm kubectl",
    "systemctl enable --now kubelet",
    ]
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.main_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "50G"
          storage = var.main_pool
        }
      }
    }
  }
}
