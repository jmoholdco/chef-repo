require 'spec_helper'

describe 'nzbget::default' do
  describe file('/usr/local/nzbget') do
    it { is_expected.to exist }
    it { is_expected.to be_executable }
  end

  describe file('/etc/nzbget.conf') do
    it { is_expected.to exist }
  end

  describe service('nzbget') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end
