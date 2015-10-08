#
# Cookbook Name:: ovirt
# Recipe:: engine
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

include_recipe 'ovirt'

return unless node['ovirt']['supported_platforms'].include?(node['platform'])

package 'ovirt-engine' do
  action :install
  notifies :create, "template[#{node['ovirt']['answers_file']}]", :immediately
  notifies :run, 'bash[engine_setup]', :immediately
end

template node['ovirt']['answers_file'] do
  source 'answers.erb'
end

bash 'engine_setup' do
  user 'root'
  environment 'PATH' => "/usr/bin:/bin:/sbin:/usr/sbin:#{ENV['PATH']}"
  code <<-EOH
    yes 'Yes' | engine-setup --config-append=#{node['ovirt']['answers_file']}
  EOH
  notifies :restart, 'service[ovirt-engine]'
  action :nothing
end

service 'ovirt-engine' do
  action [:enable, :start]
  supports restart: true, status: true
end
