#
# Cookbook Name:: jml-ubuntu-defaults
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'jml-ubuntu-defaults::user', :vault do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a user with attributes' do
      expect(chef_run).to create_user('local').with(group: 'local')
      expect(chef_run).to_not create_user('local').with(group: 'whatever')
    end

    it 'adds that user to the sudo group' do
      expect(chef_run).to modify_group('sudo').with(members: ['local'])
    end
  end
end
