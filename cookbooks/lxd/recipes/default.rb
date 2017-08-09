#
# Cookbook:: lxd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
package 'zfs' do
  action :upgrade
end

package 'lxd' do
  default_release 'xenial-backports'
  action :upgrade
end

excecute 'cat /vagrant/preseed.yaml | lxd init --preseed'
