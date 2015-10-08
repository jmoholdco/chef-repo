#
# Cookbook Name:: nameserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

package 'bind' do
  action :install
end

package 'bind-utils' do
  action :install
end
