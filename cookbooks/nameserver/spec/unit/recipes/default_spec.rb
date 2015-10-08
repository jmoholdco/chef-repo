#
# Cookbook Name:: nameserver
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nameserver::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe 'installed packages' do
      it 'installs bind' do
        expect(chef_run).to install_package 'bind'
      end

      it 'installs bind-utils' do
        expect(chef_run).to install_package 'bind'
      end
    end
  end
end
