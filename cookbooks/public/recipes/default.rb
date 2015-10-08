#
# Cookbook Name:: public
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'fail2ban::default'
include_recipe 'public::firewall_rules' unless platform_family? 'rhel'
include_recipe 'public::firewalld_rules' if platform_family? 'rhel'
