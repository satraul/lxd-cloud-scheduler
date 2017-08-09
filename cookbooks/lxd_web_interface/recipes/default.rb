#
# Cookbook:: lxd_web_interface
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
apt_repository 'rael-gc' do
  uri 'ppa:rael-gc/rvm'
  deb_src true
  action :add
end

package 'rvm' do
  action :install
end

git '/home/ubuntu/hyperkit' do
  repository 'https://github.com/satraul/hyperkit.git'
  action :sync
end

git '/home/ubuntu/lxd-web-interface' do
  repository 'https://github.com/rimara/lxd-web-interface.git'
  action :sync
end

application '/home/ubuntu/lxd-web-interface' do
  bundle_install do
    action :update
  end
  bundle_install do
    deployment true
    without %w{development test}
  end
  rails do
    database do
      adapter 'postgresql'
      host 'localhost'
      username 'lxd'
      password 'admin'
      database 'lxd-web-interface'
    end
    secret_token 'd78fe08df56c9'
    migrate true
  end
  puma do
    port 8000
  end
  action :deploy
end
