require_relative 'test_service'

services = {
  'https://some.domain' => TEST_SERVICE,
}

TEST_AUTHSERVER = Hobby::SSO::EmailingServer.new \
  services: services,
  mail: OpenStruct.new
