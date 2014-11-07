class UserMailer < ActionMailer::Base
  default from: "pixelache@gmail.com"
  
  def new_user(user)
    @user = user
    mail(to: 'nathalie@pixelache.ac',  subject: "New user: #{@user.name}") 
    mail(to: 'john@pixelache.ac',  subject: "New user: #{@user.name}") 
  end


end
