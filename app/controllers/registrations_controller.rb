class RegistrationsController < Devise::RegistrationsController
  
  def create
    @user = User.new(devise_parameter_sanitizer.sanitize(:sign_up))
    @user.password = SecureRandom.hex(32) if @user.password.blank?
    if verify_recaptcha && @user.save
      flash[:notice] = 'User information saved. Welcome.'
      sign_in_and_redirect(:user, @user)
    else

      unless flash[:recaptcha_error].blank?
        flash.delete(:recaptcha_error)
        flash[:error] = [t(:incorrect_captcha), resource.errors.full_messages].compact.join('; ')
      end
      render :action => 'new'
    end

  end
  
  def new
    @user = User.new
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
    end
  end
  
  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

end
