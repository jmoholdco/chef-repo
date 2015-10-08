module GitHubAPI
  class Nzbget
    attr_reader :auth
    def initialize
      self.class.send(:include, HTTParty)
      self.class.send(:base_uri, 'https://api.github.com')
      @auth = {
        query: { access_token: 'a02d11cc9fdbfc30918ecb9b4258bb946c6cd97d' }
      }
    end

    def latest_stable
      res = self.class.get('/repos/nzbget/nzbget/releases/latest', auth)
      res['tarball_url'] if res.success?
    end

    def latest_testing
      res = self.class.get('/repos/nzbget/nzbget/releases', auth)
      res.first['tarball_url'] if res.success?
    end

    def repo_url
      'https://github.com/nzbget/nzbget'
    end

    def self.find(release_type)
      case release_type
      when 'git' then new.repo_url
      when 'testing' then new.latest_testing
      when 'stable' then new.latest_stable
      else new.repo_url
      end
    end
  end
end
