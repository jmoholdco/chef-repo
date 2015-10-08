#
# Cookbook Name:: setup
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'setup::client' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }
    let(:dir) { chef_run.directory('/etc/chef/client.d') }
    let(:template) { chef_run.template('/etc/chef/client.d/foreman.rb') }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the chef_gem chef_handler_foreman' do
      expect(chef_run).to install_chef_gem 'chef_handler_foreman'
    end

    describe 'directory[/etc/chef/client.d]' do
      it 'creates the directory with the specified attributes' do
        expect(chef_run).to create_directory('/etc/chef/client.d').with(
          user: 'root',
          mode: 0755,
          recursive: true
        )
      end

      it 'notifies after creation' do
        expect(dir).to notify('template[/etc/chef/client.d/foreman.rb]')
          .immediately
      end
    end

    describe 'template[/etc/chef/client.d/foreman.rb]' do
      it 'creates the template' do
        expect(chef_run).to create_template('/etc/chef/client.d/foreman.rb')
          .with(source: 'foreman.rb.erb', mode: 0644)
      end

      it 'subscribes to the directory resource' do
        expect(template).to subscribe_to('directory[/etc/chef/client.d]')
      end
    end

    describe 'included recipes' do
      subject { chef_run }
      it { is_expected.to include_recipe 'chef-client::config' }
      it { is_expected.to include_recipe 'chef-client::init_service' }
    end
  end
end
