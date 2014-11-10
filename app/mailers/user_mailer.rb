class UserMailer < ActionMailer::Base
  default from: "no-reply@pixelache.ac"
  
  def new_user(user)
    @user = user
    ['nathalie@pixelache.ac', 'john@pixelache.ac'].each do |recipient|
      mail(to: recipient,  subject: "New user: #{@user.name}") 
    end
  end


end
