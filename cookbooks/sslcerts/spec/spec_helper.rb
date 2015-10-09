require 'chefspec'
require 'chefspec/berkshelf'
require 'chef-vault/test_fixtures'

RSpec.configure do |config|
  config.include ChefVault::TestFixtures.rspec_shared_context, vault: true
end
