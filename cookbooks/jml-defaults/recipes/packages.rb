#
# Cookbook Name:: jml-defaults
# Recipe:: packages
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
package 'git'
package 'zsh'
include_recipe 'vim'

virt = node.attribute?('virtualization') ? node['virtualization'] : nil

if (virt) && (virt['system'] == 'vmware') && (virt['role'] == 'guest')
  package 'open-vm-tools'
end

if platform_family?('rhel')
  yum_package 'gcc-c++'
  yum_package 'cmake'

  if node['ovirt_guest']
    include_recipe 'yum-epel'
    yum_package 'ovirt-guest-agent-common' do
      action :install
    end

    service 'ovirt-guest-agent' do
      action [:start, :enable]
    end
  end
end
