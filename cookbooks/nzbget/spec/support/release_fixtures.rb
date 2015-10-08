require 'json'

module ReleaseFixtures
  class << self
    attr_accessor :fixtures
    def fixtures
      @fixtures ||= JSON.parse(
        File.read(
          File.expand_path('../releases.json', __FILE__)
        )
      )
    end
  end

  def self.find(platform, release)
    fixtures[platform][release]
  end
end
