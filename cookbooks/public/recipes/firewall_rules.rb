#
# Cookbook Name:: public
# Recipe:: firewall_rules
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
enabled_services = node['public']['firewall']['enabled_services']

firewall 'default'

enabled_services.each do |service|
  rule = rule_lookup(service)
  firewall_rule service do
    protocol rule[:protocol]
    port rule[:port]
    command rule[:command]
  end
end

firewall_rule 'dns:tcp' do
  protocol :tcp
  port 53
  command :allow
end

firewall_rule 'dns:udp' do
  protocol :udp
  port 53
  command :allow
end
