class ApplicationMailer < ActionMailer::Base
  default from: ENV["EXAMPLE_MAIL"]
  layout "mailer"
end
