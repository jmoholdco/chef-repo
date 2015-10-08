#
# Cookbook Name:: nzbget
# Recipe:: source_git
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

cache_path = Chef::Config['file_cache_path']
conf_opts = node['nzbget']['source']['configuration']

git "#{cache_path}/nzbget" do
  repository 'https://github.com/nzbget/nzbget'
  revision 'master'
  action :sync
  notifies :run, 'bash[install_nzbget_git]', :immediately
end

bash 'install_nzbget_git' do
  cwd "#{cache_path}/nzbget"
  code <<-EOH
  touch aclocal.m4 configure Makefile.in config.h.in
  (./configure #{conf_opts} && make && make install)
  EOH
  action :nothing
end
