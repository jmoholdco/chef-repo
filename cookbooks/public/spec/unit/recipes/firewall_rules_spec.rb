#
# Cookbook Name:: public
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'public::firewall_rules' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'enables firewall rule ssh' do
      expect(chef_run).to create_firewall_rule('ssh')
    end

    it 'enables firewall rule http/https' do
      expect(chef_run).to create_firewall_rule('http/https')
    end
  end
end
