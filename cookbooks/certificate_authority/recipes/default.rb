#
# Cookbook Name:: certificate_authority
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
include_recipe 'chef-vault'
begin
  ca_certificates = chef_vault_item 'ca', 'chef'
  ca_certificates
rescue => e
  Chef::Logger.info "No Item found, including the ca:setup recipe. (#{e})"
  include_recipe 'certificate_authority::setup'
end
