#
# Cookbook Name:: ovirt
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ovirt::default' do
  shared_examples 'on a supported platform' do |platform, version|
    context "on #{platform} v#{version}" do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: platform, version: version)
          .converge(described_recipe)
      end

      let(:cache_path) { 'tmp/var/chef/cache' }
      let(:rpm) { 'ovirt-release35-005-1.noarch.rpm' }
      let(:remote) { chef_run.remote_file("#{cache_path}/#{rpm}") }

      it 'downloads the remote file' do
        expect(chef_run).to create_remote_file("#{cache_path}/#{rpm}").with(
          source: 'http://resources.ovirt.org/pub/ovirt-3.5/rpm/el7/noarch/ovirt-release35-005-1.noarch.rpm'
        )
      end

      it 'remote file notifies rpm_package' do
        expect(remote).to notify("rpm_package[#{rpm}]").immediately
      end
    end
  end

  context 'When all attributes are default, on a supported platform' do
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
