#
# Cookbook Name:: public
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'public::firewalld_rules' do
  context 'When all attributes are default, on a centos platform' do
   cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0')
        .converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes the firewalld::default recipe' do
      expect(chef_run).to include_recipe 'firewalld::default'
    end

    it 'creates a firewall rule for http' do
      expect(chef_run).to add_firewalld_service 'http'
    end

    it 'creates a firewall rule for https' do
      expect(chef_run).to add_firewalld_service 'https'
    end

    it 'creates a firewall rule for ssh' do
      expect(chef_run).to add_firewalld_service 'ssh'
    end
  end

  context 'when explicit firewall services are specified' do
    services = %w(ssh https http dns dhcp tftp)

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0') do |node|
        node.set['public']['firewalld']['services'] = services
      end.converge(described_recipe)
    end

    subject { chef_run }

    services.each do |svc|
      it { is_expected.to add_firewalld_service "#{svc}" }
    end
  end

  context 'when specific prots are specified' do
    ports = %w(993/tcp 8443/tcp)
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0') do |node|
        node.set['public']['firewalld']['ports'] = ports
      end.converge(described_recipe)
    end

    subject { chef_run }

    ports.each do |prt|
      it { is_expected.to add_firewalld_port "#{prt}" }
    end
  end
end
