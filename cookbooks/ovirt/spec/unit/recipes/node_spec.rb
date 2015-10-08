#
# Cookbook Name:: ovirt
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ovirt::node' do
  shared_examples 'on a supported platform' do |platform, version|
    context "on #{platform} v#{version}" do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: platform, version: version)
          .converge(described_recipe)
      end

      describe 'setup' do
        it 'includes the default recipe' do
          expect(chef_run).to include_recipe 'ovirt'
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end
      end

      describe 'package[vdsm]' do
        it 'installs' do
          expect(chef_run).to install_package('vdsm')
        end
      end

      describe 'service[vdsmd]' do
        it 'enables' do
          expect(chef_run).to enable_service('vdsmd')
        end
        it 'starts' do
          expect(chef_run).to start_service('vdsmd')
        end
      end
    end
  end

  describe 'supported platforms' do
    platforms = {
      'centos' => ['7.0', '7.1.1503'],
      'redhat' => ['7.0', 7.1]
    }
    platforms.each do |platform, versions|
      versions.each do |version|
        include_examples 'on a supported platform', platform, version
      end
    end
  end
end
