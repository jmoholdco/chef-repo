require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '7.1.1503'
  config.before(:each) do
    stub_command("bash -c \"source /etc/profile && type rvm | cat | head -1 | grep -q '^rvm is a function$'\"")
      .and_return(0)
  end
end
