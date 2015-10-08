#
# Cookbook Name:: setup
# Recipe:: pbcopy
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
yum_package 'nmap-ncat' if platform_family? 'rhel'

cookbook_file '/usr/local/bin/pbcopy' do
  source 'pbcopy'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end
