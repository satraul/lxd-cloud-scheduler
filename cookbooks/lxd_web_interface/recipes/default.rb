#
# Cookbook:: lxd_web_interface
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

version = '2.4.1'

# Install Rbenv Globally
rbenv_system_install 'system'

# Install a Ruby version
rbenv_ruby version do
  verbose true
end

# Set that Ruby as the global Ruby
rbenv_global version

git '/home/ubuntu/hyperkit' do
  repository 'https://github.com/satraul/hyperkit.git'
  action :sync
end

git '/home/ubuntu/lxd-web-interface' do
  repository 'https://github.com/rimara/lxd-web-interface.git'
  action :sync
end

execute "bundle install" do
  cwd "/home/ubuntu/lxd-web-interface/"
  command "bundle install"
  action :run
end
