#
# Cookbook Name:: ovirt
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

cache_path = Chef::Config[:file_cache_path]

unless node['ovirt']['supported_platforms'].include?(node['platform'])
  Chef::Log.error("#{node['platform']} is not supported by this cookbook.")
  return
end

remote_file "#{cache_path}/#{node['ovirt']['ovirt_release_rpm']}" do
  source node['ovirt']['ovirt_release_rpm_url']
  not_if 'rpm -qa | grep ovirt-release'
  notifies :install, "rpm_package[#{node['ovirt']['ovirt_release_rpm']}]", :immediately
end

rpm_package node['ovirt']['ovirt_release_rpm'] do
  source "#{cache_path}/#{node['ovirt']['ovirt_release_rpm']}"
  only_if {::File.exists?("#{cache_path}/#{node['ovirt']['ovirt_release_rpm']}")}
  action :install
end
