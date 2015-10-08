#
# Cookbook Name:: foreman
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

yum_package 'epel-release'
include_recipe 'foreman::firewall_rules'
