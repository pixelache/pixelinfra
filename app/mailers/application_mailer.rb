class ApplicationMailer < ActionMailer::Base

  helper :application 
  default from: "office@pixelache.ac"
  layout 'mailer'
end
