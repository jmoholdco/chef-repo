#
# Cookbook Name:: nzbget
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'
require 'httparty'

describe 'nzbget::source_tarball' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    describe 'fetching the tarball' do
      let(:tarball) do
        chef_run.remote_file('/var/chef/cache/nzbget-v16.0.tar.gz')
      end

      it 'fetches the remote tarball' do
        expect(chef_run).to create_remote_file(
          '/var/chef/cache/nzbget-v16.0.tar.gz'
        )
      end

      it 'notifies the bash script to run' do
        expect(tarball).to notify('bash[install_nzbget]').to(:run).immediately
      end
    end

    describe 'bash[install_nzbget]' do
      let(:script) { chef_run.bash('install_nzbget') }
      subject { script }
      it { is_expected.to do_nothing }
    end
  end
end
