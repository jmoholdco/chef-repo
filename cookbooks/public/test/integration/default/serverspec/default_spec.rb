require 'spec_helper'

describe 'public::default' do
  context 'on all platforms' do
    describe package('fail2ban') do
      it { is_expected.to be_installed }
    end
  end

  context 'when the os family is ubuntu', if: os[:family] == 'ubuntu' do
    describe package('ufw') do
      it { is_expected.to be_installed }
    end
  end

  context 'when the os family is redhat', if: os[:family] == 'redhat' do
    describe package('firewalld') do
      it { is_expected.to be_installed }
    end

    describe service('firewalld') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    shared_examples 'firewall rules' do |rule, permanent|
      if permanent
        cmd = "firewall-cmd --permanent --query-service=#{rule}"
      else
        cmd = "firewall-cmd --query-service=#{rule}"
        describe command("#{cmd}") do
          its(:exit_status) { is_expected.to eq 0 }
        end
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
  end
end
