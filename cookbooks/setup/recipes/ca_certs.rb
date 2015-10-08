#
# Cookbook Name:: setup
# Recipe:: ca_certs
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
if platform_family? 'rhel'
  ca_trust = '/etc/pki/ca-trust/source/anchors'

  cookbook_file "#{ca_trust}/ca.cert.pem" do
    source 'ca.cert.pem'
    owner 'root'
    group 'root'
    mode 0644
    action :create_if_missing
    notifies :create,
             "cookbook_file[#{ca_trust}/auth-intermediate.cert.pem]",
             :immediately
  end

  cookbook_file "#{ca_trust}/auth-intermediate.cert.pem" do
    source 'auth-intermediate.cert.pem'
    owner 'root'
    group 'root'
    mode 0644
    action :nothing
    notifies :run, 'bash[update_ca_trust]', :immediately
  end

  bash 'update_ca_trust' do
    code 'update-ca-trust extract'
    action :nothing
    user 'root'
  end
end
