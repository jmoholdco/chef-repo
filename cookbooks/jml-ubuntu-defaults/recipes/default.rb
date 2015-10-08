#
# Cookbook Name:: jml-ubuntu-defaults
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'apt::default' if platform_family?('debian')
include_recipe 'chef-vault'
include_recipe 'jml-ubuntu-defaults::packages' unless platform? 'fedora'
# include_recipe 'users::sysadmins'
include_recipe 'jml-ubuntu-defaults::user' if node['jml-ubuntu-defaults']['admin_user']
include_recipe 'jml-ubuntu-defaults::dotfiles'
