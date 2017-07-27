# -*- mode: ruby -*-
# vi: set ft=ruby :

DEFAULT_BOX = "ubuntu/xenial64"
# We actually need 2 nodes
NODE_COUNT = 1
PRESEED = File.read("preseed.yaml")

Vagrant.configure("2") do |config|
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Hello from $HOSTNAME"

    echo "Installing ZFS"
    sudo apt-get install -qq -y zfs

    echo "Installing LXD feature branch (2.X)"
    sudo apt install -qq -y -t xenial-backports lxd lxd-client

    if $(sudo lxc config get core.trust_password) ; then
        echo "LXD already initialized"
    else
        echo "Running lxd init with --preseed"
        echo "#{PRESEED}" | lxd init --preseed
    fi
  SHELL

  config.vm.define "master" do |subconfig|
    subconfig.vm.box = DEFAULT_BOX
    subconfig.vm.hostname = "master"
    subconfig.vm.provision "shell", inline: <<-SHELL
        echo "Running provisions for master"
        sudo openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /home/ubuntu/.config/lxc/client.key -out /home/ubuntu/.config/lxc/client.crt -batch
        
        echo "Copying certficate and key to root"
        sudo cp /home/ubuntu/.config/lxc/client.key /vagrant/
        sudo cp /home/ubuntu/.config/lxc/client.crt /vagrant/
    SHELL
  end

  (1..NODE_COUNT).each do |i|
    config.vm.define "node-#{i}" do |subconfig|
      subconfig.vm.box = DEFAULT_BOX
      subconfig.vm.hostname = "node-#{i}"
      subconfig.vm.provision "shell", inline: <<-SHELL
        echo "Running provisions for node"
      SHELL
    end
  end
end
