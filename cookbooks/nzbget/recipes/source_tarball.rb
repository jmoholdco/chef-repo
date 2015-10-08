#
# Cookbook Name:: nzbget
# Recipe:: source_tarball
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

cache_path = Chef::Config['file_cache_path']
release = node['nzbget']['source']['release']
source_url = GitHubAPI::Nzbget.find(release)
source_version = source_url.split('/').last
conf_opts = node['nzbget']['source']['configuration']

remote_file "#{cache_path}/nzbget-#{source_version}.tar.gz" do
  source source_url
  checksum node['nzbget']['source']['checksum']
  notifies :run, 'bash[install_nzbget]', :immediately
end

bash 'install_nzbget' do
  cwd cache_path
  code <<-EOH
  mkdir nzbget-#{source_version}
  tar -zxf nzbget-#{source_version}.tar.gz -C nzbget-#{source_version} --strip-components 1
  (cd nzbget-#{source_version}/ && ./configure #{conf_opts} && make && make install)
  make install-conf
  EOH
  action :nothing
end
