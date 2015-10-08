#
# Cookbook Name:: foreman
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'foreman::firewall_rules' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe 'created firewall rules' do
      it 'http/https' do
        expect(chef_run).to add_firewalld_service 'http'
        expect(chef_run).to add_firewalld_service 'https'
      end

      it 'dns' do
        expect(chef_run).to add_firewalld_service 'dns'
      end

      it 'dhcp' do
        expect(chef_run).to add_firewalld_service 'dhcp'
      end

      it 'tftp' do
        expect(chef_run).to add_firewalld_service 'tftp'
      end

      it 'puppet master' do
        expect(chef_run).to add_firewalld_port '8140/tcp'
      end

      it 'smart proxy' do
        expect(chef_run).to add_firewalld_port '8443/tcp'
      end
    end
  end
end
