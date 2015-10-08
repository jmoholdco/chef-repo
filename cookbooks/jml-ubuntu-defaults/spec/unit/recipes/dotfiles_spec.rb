#
# Cookbook Name:: jml-ubuntu-defaults
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'jml-ubuntu-defaults::dotfiles' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'checks out the dotfiles repo into the home directory' do
      expect(chef_run).to sync_git('/home/local/dotfiles')
        .with(repository: 'https://github.com/baberthal/dotfiles.git')
    end

    it 'links the necessary dotfiles' do
      expect(chef_run).to create_link('/home/local/.vim')
        .with(to: '/home/local/dotfiles/vim')
      expect(chef_run).to create_link('/home/local/.oh-my-zsh')
        .with(to: '/home/local/dotfiles/oh-my-zsh')
      expect(chef_run).to create_link('/home/local/.zextra')
        .with(to: '/home/local/dotfiles/zextra')
    end

    describe 'vimrc' do
      it 'creates itself from a template' do
        expect(chef_run).to create_template('/home/local/.vimrc')
      end
    end

    describe 'zdots' do
      it 'creates zshrc from a template' do
        expect(chef_run).to create_template('/home/local/.zshrc')
      end
      it 'creates cookbook_file zshenv' do
        expect(chef_run).to create_cookbook_file('/home/local/.zshenv')
      end
    end
  end
end
