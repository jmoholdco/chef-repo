#
# Cookbook Name:: public
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'public::default' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'includes fail2ban' do
      expect(chef_run).to include_recipe 'fail2ban'
    end

    it 'includes firewall_rules' do
      expect(chef_run).to include_recipe 'public::firewall_rules'
    end
  end
end
