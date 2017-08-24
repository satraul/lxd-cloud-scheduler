# -*- mode: ruby -*-
# vi: set ft=ruby :

DEFAULT_BOX = "ubuntu/xenial64"
ENABLE_WEB_INTERFACE = false
# We actually need 3 nodes
NODE_COUNT = 2
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

    # Network
    config.vm.network "private_network", type: "dhcp"

    # Web interface
    if ENABLE_WEB_INTERFACE
        config.vm.define "web-interface" do |subconfig|
            subconfig.vm.box = DEFAULT_BOX
            subconfig.vm.hostname = "web-interface"
            subconfig.vm.synced_folder 'shared/web-interface', '/vagrant'

            # Provisioning using chef-solo
            subconfig.vm.provision "chef_solo" do |chef|
                chef.cookbooks_path = ["vendor/cookbooks", "cookbooks"]
                chef.roles_path = "roles"
                chef.add_role("web-interface")
                chef.json = JSON.parse(File.read('roles/web-interface-attributes.json'))
            end
        end
    end

    # LXD nodes
    (1..NODE_COUNT).each do |i|
        config.vm.define "node-#{i}" do |subconfig|
            subconfig.vm.box = DEFAULT_BOX
            subconfig.vm.hostname = "node-#{i}"
            subconfig.vm.synced_folder 'shared/node', '/vagrant'

            subconfig.vm.provision "chef_solo" do |chef|
                chef.cookbooks_path = ["vendor/cookbooks", "cookbooks"]
                chef.roles_path = "roles"
                chef.add_role("node")
            end
        end
    end
end
