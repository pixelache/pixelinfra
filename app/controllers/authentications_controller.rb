class AuthenticationsController < ApplicationController  
  def index  
  end  
  
  def handle_unverified_request
    true
  end



  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to '/'
    elsif auth = Authentication.find_by_username_and_provider(omniauth['info']['nickname'], omniauth['provider'])
      auth.update(:provider => omniauth['provider'], :uid => omniauth['uid'], :username => omniauth['info']['nickname'])
      user = auth.user
      sign_in_and_redirect(:user, user)

    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.email?
        if existing_user = User.find_by(:email => user.email)
          user = existing_user
          if user.authentications.where(:provider => omniauth['provider']).empty?
            user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :username => (omniauth['info']['nickname'].blank? ? omniauth['info']['email'] : omniauth['info']['nickname']))
          end
        end
          user.save!
          flash[:notice] = "Signed in successfully with " +  omniauth['provider']
          sign_in_and_redirect(:user, user)
      else
        flash[:alert] = "Please complete registration"
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
    
  def destroy  
  end  
  
  def root_path
    '/'
  end
end