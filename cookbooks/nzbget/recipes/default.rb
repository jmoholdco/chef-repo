#
# Cookbook Name:: nzbget
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

chef_gem 'httparty' do
  compile_time true
end

gem_package 'httparty'
require 'httparty'

include_recipe 'nzbget::source'

service 'nzbget' do
  init_command '/usr/local/nzbget -D'
  stop_command '/usr/local/nzbget -Q'
  action [:enable, :start]
end
