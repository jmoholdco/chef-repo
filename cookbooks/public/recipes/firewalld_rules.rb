#
# Cookbook Name:: public
# Recipe:: firewalld_rules
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
services     = node['public']['firewalld']['services']
ports        = node['public']['firewalld']['ports']
default_zone = node['public']['firewalld']['default_zone']

include_recipe 'firewalld::default'

services.each do |svc|
  firewalld_service svc do
    action :add
    zone default_zone
  end
end

unless ports.nil?
  ports.each do |prt|
    firewalld_port prt do
      action :add
      zone default_zone
    end
  end
end
