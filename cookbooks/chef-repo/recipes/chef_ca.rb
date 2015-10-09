#
# Cookbook Name:: chef-repo
# Recipe:: chef_ca
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
include_recipe 'x509::default'

x509_certificate 'chef.jmorgan.org' do
  certificate '/etc/pki/tls/certs/chef.jmorgan.org.crt'
  cacertificate '/etc/pki/CA/certs/ca.crt'
  key '/etc/pki/tls/private/chef.jmorgan.org.key'
  ca 'Chef CA'
  type 'server'
  bits 4096
  days 365
end
