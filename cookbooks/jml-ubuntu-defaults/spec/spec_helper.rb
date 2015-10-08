require 'chefspec'
require 'chefspec/berkshelf'
require 'chef-vault/test_fixtures'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.include ChefVault::TestFixtures.rspec_shared_context, vault: true
  config.extend ChefSpec::Cacher
end
