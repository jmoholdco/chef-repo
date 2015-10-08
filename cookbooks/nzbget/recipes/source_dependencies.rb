#
# Cookbook Name:: nzbget
# Recipe:: source_dependencies
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

node['nzbget']['source']['dependencies'].each do |dep|
  package dep do
    action :install
  end
end
