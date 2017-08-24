#
# Cookbook:: lxd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -"

packages = ['python', 'make', 'gcc', 'g++', 'nodejs', 'zfs']

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end

package 'lxd' do
  default_release 'xenial-backports'
  action :upgrade
end

execute 'cat /vagrant/preseed.yaml | lxd init --preseed' do
  ignore_failure true
end

execute 'npm install' do
  cwd '/vagrant/xterm-server'
  action :run
end
