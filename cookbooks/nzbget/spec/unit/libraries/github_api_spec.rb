require 'spec_helper'
require 'httparty'
require_relative '../../../libraries/github_api.rb'

RSpec.describe GitHubAPI::Nzbget do
  let(:api) { described_class.new }
  describe '#latest_stable' do
    it 'returns the tarball url of the latest stable release' do
      expect(api.latest_stable).to eq(
        'https://api.github.com/repos/nzbget/nzbget/tarball/v16.0')
    end
  end

  describe '#latest_testing' do
    it 'returns the tarball url of the latest testing release' do
      expect(api.latest_testing).to eq('https://api.github.com/repos/nzbget/nzbget/tarball/v16.0')
    end
  end
end
