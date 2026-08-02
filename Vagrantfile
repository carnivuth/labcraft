# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Simulated storage layout (scaled down from real hardware):
#   sdb -> "NVMe" 1TB   -> 10G  -> LVM only
#   sdc -> HDD 2TB      -> 20G  -> mdadm RAID1 (with sdd) + LVM
#   sdd -> HDD 2TB      -> 20G  -> mdadm RAID1 (with sdc) + LVM
#   sde -> HDD 1TB      -> 10G  -> LVM only
#
# Provider: VirtualBox

VM_NAME   = "avalug"
BOX_IMAGE = "debian/bookworm64"

DISKS = [
  { file: "disk_nvme.vdi", size_mb: 10 * 1024 },  # simulated NVMe 1TB -> 10G
  { file: "disk_hdd1.vdi", size_mb: 20 * 1024 },  # HDD 2TB -> 20G
  { file: "disk_hdd2.vdi", size_mb: 20 * 1024 },  # HDD 2TB -> 20G
  { file: "disk_hdd3.vdi", size_mb: 10 * 1024 },  # HDD 1TB -> 10G
]

Vagrant.configure("2") do |config|
  config.vm.box = BOX_IMAGE
  config.vm.hostname = VM_NAME
  config.vm.network 'forwarded_port', id: 'ssh', host: 2221, guest: 22

  config.vm.provider "virtualbox" do |vb|
    vb.name = VM_NAME
    vb.memory = 4096
    vb.cpus = 2

    # SATA controller that ships with the box is usually "SATA Controller"
    controller = "SATA Controller"

    DISKS.each_with_index do |disk, i|
      disk_path = File.join(File.dirname(__FILE__), ".vagrant", "disks", disk[:file])

      unless File.exist?(disk_path)
        vb.customize [
          "createmedium", "disk",
          "--filename", disk_path,
          "--size", disk[:size_mb],
          "--format", "VDI"
        ]
      end

      vb.customize [
        "storageattach", :id,
        "--storagectl", controller,
        "--port", 1 + i,   # port 0 is the boot disk
        "--device", 0,
        "--type", "hdd",
        "--medium", disk_path
      ]
    end
  end

  # Basic package prep so you can build the RAID/LVM/Docker setup by hand
  # (or extend this script to fully automate it).
  config.vm.provision "shell", inline: <<-SHELL
    set -e
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y lvm2 mdadm parted xfsprogs curl gnupg make

    # Install Docker CE
    if ! command -v docker >/dev/null 2>&1; then
      install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
      chmod a+r /etc/apt/keyrings/docker.asc
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" \
        > /etc/apt/sources.list.d/docker.list
      apt-get update
      apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
      usermod -aG docker vagrant
    fi

    echo Installing docker lvm plugin
    curl -sL https://github.com/containers/docker-lvm-plugin/releases/download/v1.0/docker-lvm-plugin > /usr/local/bin/docker-lvm-plugin
    chmod +x /usr/local/bin/docker-lvm-plugin

    echo "== Attached block devices =="
    lsblk -d -o NAME,SIZE,MODEL | grep -v loop
    echo
    echo "Disks are attached but NOT partitioned/formatted yet."
    echo "Expected mapping inside the VM (verify with lsblk, may vary):"
    echo "  /dev/sdb -> simulated NVMe (10G)  -> vg_nvme"
    echo "  /dev/sdc -> HDD 2TB (20G)         -> RAID1 member -> vg_data"
    echo "  /dev/sdd -> HDD 2TB (20G)         -> RAID1 member -> vg_data"
    echo "  /dev/sde -> HDD 1TB (10G)         -> vg_backup"
    test ! -f /dev/md/data && mdadm  --create /dev/md/data -R --level 1 --raid-devices 2 /dev/sdc /dev/sdd
    vgcreate vg_data /dev/md/data
    vgcreate vg_backup /dev/sde
    lvcreate -L 10G -n lv_data vg_data
    lvcreate -L 9G -n lv_backup vg_backup
    mkfs.ext4 /dev/vg_data/lv_data
    mkfs.ext4 /dev/vg_backup/lv_backup
    mkdir -p /mnt/{data,backup}
    mount /dev/vg_data/lv_data /mnt/data
    mount /dev/vg_backup/lv_backup /mnt/backup

  SHELL
end
