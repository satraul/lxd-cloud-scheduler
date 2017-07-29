# -*- mode: ruby -*-
# vi: set ft=ruby :

DEFAULT_BOX = "ubuntu/xenial64"
# We actually need 2 nodes
NODE_COUNT = 1
ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
  end

  config.vm.provision "shell", path: "provisioners/general.sh"

  config.vm.define "master" do |subconfig|
    subconfig.vm.box = DEFAULT_BOX
    subconfig.vm.network "public_network", type: "dhcp"
    subconfig.vm.hostname = "master"
    subconfig.vm.provision "shell", path: "provisioners/master.sh"
  end

  (1..NODE_COUNT).each do |i|
    config.vm.define "node-#{i}" do |subconfig|
      subconfig.vm.box = DEFAULT_BOX
      subconfig.vm.network "private_network", type: "dhcp"
      subconfig.vm.hostname = "node-#{i}"
      subconfig.vm.provision "shell", path: "provisioners/node.sh"
    end
  end
end
