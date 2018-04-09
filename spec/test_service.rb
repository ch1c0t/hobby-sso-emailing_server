class MockRedis
  def initialize
    @hash = {}
  end

  def get key
    @hash[key]
  end

  def set key, value
    @hash[key] = value
  end
end

TEST_SERVICE = Hobby::SSO::EmailingServer::Service.new \
  sessions: MockRedis.new,
  tickets: MockRedis.new
