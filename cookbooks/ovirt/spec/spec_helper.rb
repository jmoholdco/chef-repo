require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.file_cache_path = 'tmp/var/chef/cache'
  config.before(:each) do
    stub_command('rpm -qa | grep ovirt-release').and_return(false)
  end
end
