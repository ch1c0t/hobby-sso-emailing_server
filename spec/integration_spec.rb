require_relative 'helper'

describe do
  let(:browser) { Watir::Browser.new }

  it do
    browser.goto 'http://127.0.0.1:8080?service=https://some.domain'
    form = browser.form
    form.text_field(name: 'email').set 'chertoly@gmail.com'
    form.submit

    assert { browser.text.include? 'A link for entering to https://some.domain has been sent to chertoly@gmail.com.' }
  end

  after do
    browser.quit
  end
end
