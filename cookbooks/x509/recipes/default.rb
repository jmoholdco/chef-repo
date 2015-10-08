#
# Cookbook Name:: x509
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'vt-gpg' if node['x509']['key_vault']
chef_gem 'eassl2' { action :nothing }.run_action(:upgrade)
require 'eassl'
