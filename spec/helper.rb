require 'hobby/sso/emailing_server'

require 'ostruct'
require 'watir'

require 'rspec/power_assert'
RSpec::PowerAssert.example_assertion_alias :assert
RSpec::PowerAssert.example_group_assertion_alias :assert

RSpec.configure do |config|
  config.before :suite do
    $test_app_pid = fork do
      require_relative 'test_authserver'
      require 'puma'
      server = Puma::Server.new TEST_AUTHSERVER
      server.add_tcp_listener '127.0.0.1', 8080
      server.run
      sleep
    end
  end

  config.after :suite do
    `kill #{$test_app_pid}`
  end
end
