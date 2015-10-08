#
# Cookbook Name:: foreman
# Recipe:: rubies
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

rvm_ruby '2.2.2' do
  action :install
end

rvm_ruby '2.2.3' do
  action :install
end

rvm_default_ruby '2.2.2'
