#
# Cookbook Name:: x509
# Recipe:: local_ca
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

node.set['cacerts'] ||= {}

certs_dir = node['x509']['certs_dir']

search('certificates') do |item|
  unless item['cacert'].nil?
    cert = OpenSSL::X509::Certificate.new(item['cacert'])
    hash = sprintf("%x", cert.subject.hash)
    hash_path = File.join(certs_dir, "#{hash}.0")

    if !node['cacerts'].has_key(hash_path) || node['cacerts'][hash_path] != item['cacert']
      file hash_path do
        content item['cacert']
        action :create
        owner 'root'
        group 'root'
        mode 0644
      end

      node.set['cacerts'][hash_path] = item['cacert']
    end
  end
end
