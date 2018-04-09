Gem::Specification.new do |g|
  g.name    = 'hobby-sso-emailing_server'
  g.files   = `git ls-files`.split($/)
  g.version = '0.0.0'
  g.summary = 'A hobby-sso server providing authentication links to emails.'
  g.authors = ['Anatoly Chernow']

  g.add_dependency 'hobby'
  g.add_dependency 'mail'
  g.add_dependency 'email_address'
  g.add_dependency 'slim'
end
