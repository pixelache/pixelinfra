class ApplicationController < ActionController::Base
  protect_from_forgery
  theme :determine_site
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  private

  def determine_site
    'pixelache'
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_token, :remember_created_at, :sign_in_count) }
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :username, :email,  authentications_attributes: [:id, :provider, :username ] )}    
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :name, :username, :password_confirmation, authentications_attributes: [:id, :provider, :username ] ) }
  end
  
end
