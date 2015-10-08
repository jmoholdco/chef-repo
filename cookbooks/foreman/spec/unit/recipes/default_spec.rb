#
# Cookbook Name:: foreman
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'foreman::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs the epel-release package' do
      expect(chef_run).to install_yum_package 'epel-release'
    end
  end
end
