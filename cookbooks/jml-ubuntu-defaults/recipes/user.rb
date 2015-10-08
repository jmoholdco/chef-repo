#
# Cookbook Name:: jml-ubuntu-defaults
# Recipe:: user
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

default_attrs = {
  group: node['jml-ubuntu-defaults']['admin_user']['group'],
  user: node['jml-ubuntu-defaults']['admin_user']['user'],
  shell: node['jml-ubuntu-defaults']['admin_user']['shell'],
  dotfiles_repo: node['jml-ubuntu-defaults']['admin_user']['dotfiles_repo'],
  password: chef_vault_item('passwords', 'local'),
  sudo_group: node['jml-ubuntu-defaults']['admin_user']['sudo_group']
}

group default_attrs[:group]

user default_attrs[:user] do
  group default_attrs[:group]
  shell default_attrs[:shell]
  action :create
  manage_home true
  home "/home/#{default_attrs[:user]}"
  password default_attrs[:password]['password']
end

group default_attrs[:sudo_group] do
  action :modify
  append true
  members default_attrs[:user]
end
