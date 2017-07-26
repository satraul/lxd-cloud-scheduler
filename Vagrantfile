# -*- mode: ruby -*-
# vi: set ft=ruby :

DEFAULT_BOX = "ubuntu/xenial64"
# We actually need 2 nodes
NODE_COUNT = 1
PRESEED = File.read("preseed.yaml")

Vagrant.configure("2") do |config|
  config.vm.define "master" do |subconfig|
    subconfig.vm.box = DEFAULT_BOX
    subconfig.vm.hostname = "master"
    subconfig.vm.provision "shell", inline: <<-SHELL
        echo "Hello from master"
        echo Installing ZFS
        sudo apt-get install -qq -y zfs
        echo "Running apt install -qq -y -t xenial-backports lxd lxd-client"
        sudo apt install -qq -y -t xenial-backports lxd lxd-client
        echo "Running lxd init --preseed"
        echo "#{PRESEED}" | lxd init --preseed
    SHELL
  end

  (1..NODE_COUNT).each do |i|
    config.vm.define "node-#{i}" do |subconfig|
      subconfig.vm.box = DEFAULT_BOX
      subconfig.vm.hostname = "node-#{i}"
      subconfig.vm.provision "shell", inline: <<-SHELL
        echo "Hello from node #{i}"
        echo "Running apt-get -qq -y install zfs"
        sudo apt-get -qq -y install zfs
        echo "Running apt install -qq -y -t xenial-backports lxd lxd-client"
        sudo apt install -qq -y -t xenial-backports lxd lxd-client
        echo "#{PRESEED}" | lxd init --preseed
      SHELL
    end
  end

  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
  end
end
