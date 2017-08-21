# -*- mode: ruby -*-
# vi: set ft=ruby :

DEFAULT_BOX = "ubuntu/xenial64"
# We actually need 2 nodes
NODE_COUNT = 1
ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
    # Set VM RAM and CPU
    config.vm.provider "virtualbox" do |vb|
        host = RbConfig::CONFIG['host_os']

        if host =~ /darwin/
            # MacOS, returns bytes
            total_memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024
        elsif host =~ /linux/
            # Linux, returns KB
            total_memory = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024
        elsif host =~ /mswin|mingw|cygwin/
            # Windows, returns bytes
            total_memory = `wmic computersystem Get TotalPhysicalMemory`.split[1].to_i / 1024 / 1024
        end

        # Give VM 1/4 memory
        vb.memory = total_memory/4
        vb.cpus = 2
    end

    # Network and folder sync
    config.vm.synced_folder 'nfs', '/vagrant', nfs: true
    config.vm.network "private_network", type: "dhcp"

    # Master
    config.vm.define "master" do |subconfig|
        subconfig.vm.box = DEFAULT_BOX
        subconfig.vm.hostname = "master"
        subconfig.vm.network "forwarded_port", guest: 3000, host: 8080

        # Provisioning using chef-solo
        subconfig.vm.provision "chef_solo" do |chef|
            chef.cookbooks_path = ["vendor/cookbooks", "cookbooks"]
            chef.roles_path = "roles"
            chef.add_role("master")
            chef.json = JSON.parse(File.read('roles/master_attr.json'))
        end
    end

    # Nodes
    (1..NODE_COUNT).each do |i|
        config.vm.define "node-#{i}" do |subconfig|
            subconfig.vm.box = DEFAULT_BOX
            subconfig.vm.hostname = "node-#{i}"
            subconfig.vm.provision "chef_solo" do |chef|
                chef.roles_path = "roles"
                chef.add_role("node")
            end
        end
    end
end
