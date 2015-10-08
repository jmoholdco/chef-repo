#
# Cookbook Name:: ovirt
# Recipe:: node
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

include_recipe 'ovirt'

return unless node['ovirt']['supported_platforms'].include? node['platform']

package 'vdsm' do
  action :install
end

service 'vdsmd' do
  action [:enable, :start]
end
