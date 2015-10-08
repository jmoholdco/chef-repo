#
# Cookbook Name:: sslcerts
# Recipe:: signer
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

nodes_with_outstanding_reqs = search(:node, 'csr_outbox:*')
signing_queue = []
nodes_with_outstanding_reqs.each do |n|
  signing_queue << n['csr_outbox'].to_h
end

Chef::Log.info(signing_queue)
