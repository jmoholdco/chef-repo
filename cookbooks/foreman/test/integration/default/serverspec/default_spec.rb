require 'spec_helper'

describe 'foreman::default' do
  describe service('firewalld') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  shared_examples 'firewall rules' do |rule, permanent|
    if permanent
      cmd = "firewall-cmd --permanent --query-service=#{rule}"
    else
      cmd = "firewall-cmd --query-service=#{rule}"
    end
    describe command("#{cmd}") do
      its(:exit_status) { is_expected.to eq 0 }
    end
  end

  describe 'default firewall rules' do
    include_examples 'firewall rules', 'http', false
    include_examples 'firewall rules', 'http', true
    include_examples 'firewall rules', 'https', false
    include_examples 'firewall rules', 'https', true
    include_examples 'firewall rules', 'ssh', false
    include_examples 'firewall rules', 'ssh', true
  end

  describe command('which ruby') do
    its(:exit_status) { is_expected.to eq 0 }
    its(:stdout) { is_expected.to match(%r{/usr/local/rvm/rubies/}) }
  end
end
