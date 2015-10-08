#
# Cookbook Name:: nzbget
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'
require 'httparty'

describe 'nzbget::source' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe 'included recipes' do
      subject { chef_run }
      it { is_expected.to include_recipe 'nzbget::source_dependencies' }
      it { is_expected.to include_recipe 'nzbget::source_tarball' }
    end
  end
end
