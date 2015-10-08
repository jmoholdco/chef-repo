#
# Cookbook Name:: foreman
# Recipe:: firewall_rules
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
#

include_recipe 'firewalld::default'

firewalld_service 'http' do
  action :add
end

firewalld_service 'https' do
  action :add
end

firewalld_service 'dns' do
  action :add
end

firewalld_service 'dhcp' do
  action :add
end

firewalld_service 'tftp' do
  action :add
end

firewalld_port '8140/tcp' do
  action :add
end

firewalld_port '8443/tcp' do
  action :add
end

firewalld_service 'ssh' do
  action :add
end
