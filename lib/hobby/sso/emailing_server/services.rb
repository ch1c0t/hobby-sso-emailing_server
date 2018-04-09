module Hobby::SSO
  class EmailingServer
    class Services
      def initialize hash
        @services = hash
      end

      def [] domain
        service = @services[domain]
        service = service.dup
        service.domain = domain
        service
      end
    end
  end
end
