module Hobby::SSO
  class EmailingServer
    class Service
      def initialize sessions:, tickets:
        @sessions, @tickets = sessions, tickets
      end

      attr_accessor :domain

      def to_s
        @domain
      end

      def create_session user_id
        session, ticket = random, random
        @sessions.set session, user_id
        @tickets.set ticket, session
        link_with_ticket ticket
      end

      private
        def random
          SecureRandom.urlsafe_base64 64
        end

        def link_with_ticket ticket
          "#{domain}/enter?ticket=#{ticket}"
        end
    end
  end
end
