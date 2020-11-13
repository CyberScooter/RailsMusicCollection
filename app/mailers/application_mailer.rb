class ApplicationMailer < ActionMailer::Base
  default to: "info@musiccollection.com", from: "info@musiccollection.com"
  layout 'mailer'
end
