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
  config.vm.network "private_network", ip: "192.168.56.15"

  config.vm.provider "virtualbox" do |vb|
    vb.name = VM_NAME
    vb.memory = 4096
    vb.cpus = 4

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
    apt-get install -y lvm2 mdadm parted xfsprogs curl gnupg make vim

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
