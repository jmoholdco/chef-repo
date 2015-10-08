#
# Cookbook Name:: nzbget
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nzbget::source_git' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe 'fetching the git repo' do
      let(:git_repo) { chef_run.git('/var/chef/cache/nzbget') }
      it 'syncs from the master branch' do
        expect(chef_run).to sync_git('/var/chef/cache/nzbget').with(
          repository: 'https://github.com/nzbget/nzbget'
        )
      end

      it 'notifies the bash script to run' do
        expect(git_repo).to notify('bash[install_nzbget_git]')
          .to(:run).immediately
      end
    end

    describe 'bash[install_nzbget_git]' do
      let(:script) { chef_run.bash('install_nzbget_git') }
      subject { script }
      it { is_expected.to do_nothing }
    end
  end
end
