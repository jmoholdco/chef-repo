#
# Cookbook Name:: nzbget
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nzbget::source_dependencies' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe 'installing dependencies' do
      %w(libxml2-dev libssl-dev libncurses5-dev build-essential).each do |d|
        it "installs #{d}" do
          expect(chef_run).to install_package d
        end
      end
    end
  end
end
