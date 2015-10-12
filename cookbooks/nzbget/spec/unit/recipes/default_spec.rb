#
# Cookbook Name:: nzbget
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nzbget::default' do
  context 'When all attributes are default, on an ubuntu platform' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe 'gem `httparty`' do
      subject { chef_run }
      it { is_expected.to install_chef_gem 'httparty' }
      it { is_expected.to install_gem_package 'httparty' }
    end

    it 'includes the source recipe' do
      expect(chef_run).to include_recipe('nzbget::source')
    end

    it 'enables the service' do
      expect(chef_run).to enable_service('nzbget').with(
        init_command: '/usr/local/nzbget -D',
        stop_command: '/usr/local/nzbget -Q'
      )
    end
  end
end
