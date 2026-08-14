Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.uri = "qemu:///session"
    libvirt.qemu_use_session = true
    libvirt.system_uri = 'qemu:///system'
    libvirt.storage_pool_path = '/home/matteo/.local/share/libvirt/images'
  end

  config.vm.define :avalug do |avalug|

    avalug.vm.box = "debian/trixie64"
    config.vm.hostname = "avalug"
    config.vm.network "private_network", ip: "192.168.56.15"
    config.vm.synced_folder "./", "/vagrant", disabled: true


    config.vm.provider :libvirt do |libvirt|

      libvirt.storage :file, :size => '20G', :device => 'vdb', :type => 'raw'
      libvirt.storage :file, :size => '20G', :device => 'vdc', :type => 'raw'
      libvirt.storage :file, :size => '10G', :device => 'vde', :type => 'raw'

    end

    # shell script to create raid disk, vgs and lvs
    config.vm.provision "shell", inline: <<-SHELL
    set -e
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y lvm2 mdadm parted xfsprogs curl gnupg make vim

    test ! -f /dev/md/data && mdadm  --create /dev/md/data -R --level 1 --raid-devices 2 /dev/vdb /dev/vdc
    vgcreate vg_data /dev/md/data
    vgcreate vg_backup /dev/vde
    lvcreate -L 10G -n lv_data vg_data
    lvcreate -L 9G -n lv_backup vg_backup
    mkfs.ext4 /dev/vg_data/lv_data
    mkfs.ext4 /dev/vg_backup/lv_backup
    mkdir -p /mnt/{data,backup}
    mount /dev/vg_data/lv_data /mnt/data
    mount /dev/vg_backup/lv_backup /mnt/backup

    SHELL
  end
end
