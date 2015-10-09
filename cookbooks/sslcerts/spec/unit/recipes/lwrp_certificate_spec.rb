require 'spec_helper'

RSpec.describe 'test::lwrp_certificate_spec', :vault do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end
