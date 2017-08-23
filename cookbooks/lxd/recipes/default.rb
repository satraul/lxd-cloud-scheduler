#
# Cookbook:: lxd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -"

package 'nodejs' do
    action :upgrade
end

package 'zfs' do
    action :upgrade
end

package 'lxd' do
    default_release 'xenial-backports'
    action :upgrade
end

execute 'cat /vagrant/preseed.yaml | lxd init --preseed' do
    ignore_failure true
end

git '/home/ubuntu/xterm.js' do
    repository 'https://github.com/sourcelair/xterm.js.git'
    action :sync
end

execute 'npm install' do
    cwd '/home/ubuntu/xterm.js'
    action :run
end
