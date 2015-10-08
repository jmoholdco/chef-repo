#
# Cookbook Name:: ssl_certs
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

directory '/etc/pki/tls/csr' do
  recursive true
  notifies :create, "sslcerts_signing_req[/etc/pki/tls/csr/#{node['fqdn']}.csr]"
end

sslcerts_signing_req "/etc/pki/tls/csr/#{node['fqdn']}.csr" do
  common_name node['fqdn']
  org 'JML Holdings, LLC'
  country 'US'
  city 'Denver'
  state 'Colorado'
  email "root@#{node['fqdn']}"
end
