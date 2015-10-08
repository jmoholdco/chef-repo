#
# Cookbook Name:: nzbget
# Recipe:: source
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

include_recipe 'nzbget::source_dependencies'

release = node['nzbget']['source']['release']

if release == 'git'
  include_recipe 'nzbget::source_git'
else
  include_recipe 'nzbget::source_tarball'
end
