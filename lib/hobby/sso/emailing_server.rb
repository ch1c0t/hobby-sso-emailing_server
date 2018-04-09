require 'hobby'
require 'mail'
require 'email_address'
require 'slim'

require_relative 'emailing_server/services'
require_relative 'emailing_server/service'

module Hobby::SSO
  class EmailingServer
    include Hobby

    use Rack::ContentType, 'text/html'

    def initialize services: {}, mail: Mail.new,
        page_for_providing_email: Slim::Template.new("#{__dir__}/emailing_server/page_for_providing_email.slim")
      @services, @mail = Services.new(services), mail
      @page_for_providing_email = page_for_providing_email
    end

    def service
      @service ||= @services[request.params['service']]
    end

    def email
      @email ||= begin
                   email = request.params['email']
                   email if EmailAddress.valid? email
                 end
    end

    get do
      if service
        @page_for_providing_email.render self
      else
        'Please specify to which service you would like to authenticate.'
      end
    end

    post do
      if service && email
        begin
          send_link service.create_session email
          "A link for entering to #{@service} has been sent to #{email}."
        rescue
          p $!
          'A link has not been sent cause something went wrong, sorry.'
        end
      else
        'Not appropriate service or email.'
      end
    end

    def send_link link
      @mail.to = email
      @mail.subject = "A login link to #{service} issued at #{Time.now}"
      @mail.body = "During a short period of time, you will be able to login to #{service} by following this link:\n\n#{link}"
      @mail.deliver
    end
  end
end
