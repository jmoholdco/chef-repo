require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.extend ChefSpec::Cacher
end
