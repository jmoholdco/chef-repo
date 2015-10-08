#
# Cookbook Name:: ovirt
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ovirt::engine' do
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

      describe 'package[ovirt-engine]' do
        let(:engine) { chef_run.package('ovirt-engine') }
        it 'installs' do
          expect(chef_run).to install_package('ovirt-engine')
        end

        it 'notifies the template to create' do
          expect(engine).to notify(
            'template[/var/lib/ovirt-engine/setup/answers/answers-from-chef]'
          ).to(:create).immediately
        end

        it 'notifies bash[engine_setup] to run' do
          expect(engine).to notify('bash[engine_setup]').to(:run).immediately
        end
      end

      describe 'template[answers]' do
        it 'creates the template properly' do
          expect(chef_run).to create_template(
            '/var/lib/ovirt-engine/setup/answers/answers-from-chef'
          ).with(source: 'answers.erb')
        end
      end

      describe 'bash[engine_setup]' do
        let(:script) { chef_run.bash('engine_setup') }
        it 'does nothing' do
          expect(script).to do_nothing
        end

        it 'notifies service[ovirt-engine] to restart' do
          expect(script).to notify('service[ovirt-engine]').to(:restart)
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
