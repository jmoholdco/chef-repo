#
# Cookbook Name:: ovirt
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

yum_repository 'virt7-kvm-common-release' do
  description 'virt7-kvm-common-release'
  baseurl 'http://cbs.centos.org/repos/virt7-kvm-common-release/x86_64/os'
  action :create
  enabled true
  gpgcheck false
end

yum_repository 'virt7-ovirt-common-release' do
  description 'virt7-ovirt-common-release'
  baseurl 'http://cbs.centos.org/repos/virt7-ovirt-common-release/x86_64/os'
  action :create
  enabled true
  gpgcheck false
end

yum_repository 'virt7-ovirt-35-release' do
  description 'virt7-ovirt-35-release'
  baseurl 'http://cbs.centos.org/repos/virt7-ovirt-35-release/x86_64/os'
  action :create
  enabled true
  gpgcheck false
end

cache_dir = Chef::Config[:file_cache_path]
rpm_to_install = node['ovirt']['ovirt_release_rpm']

remote_file "#{cache_dir}/#{rpm_to_install}" do
  source node['ovirt']['ovirt_release_rpm_url']
  not_if 'rpm -qa | grep ovirt-release'
  notifies :install, "rpm_package[#{rpm_to_install}]", :immediately
end

rpm_package rpm_to_install do
  source "#{cache_dir}/#{rpm_to_install}"
  only_if { ::File.exists?("#{cache_dir}/#{rpm_to_install}") }
  action :nothing
end
