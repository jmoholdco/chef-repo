#
# Cookbook Name:: sslcerts
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'sslcerts::signer' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.1.1503')
        .converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
