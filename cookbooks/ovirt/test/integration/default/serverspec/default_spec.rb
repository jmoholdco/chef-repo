require 'spec_helper'

describe 'ovirt::default' do
  describe package('ovirt-release-el.noarch.rpm') do
    it { is_expected.to be_installed }
  end

  describe package('ovirt-engine') do
    it { is_expected.to be_installed }
  end

  describe service('ovirt-engine') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
