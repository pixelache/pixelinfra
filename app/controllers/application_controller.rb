class ApplicationController < ActionController::Base
  protect_from_forgery
  include ThemesForRails::ActionController 
  theme :determine_site
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :get_locale
  
  def reroute
    url_parts = params[:url].split(/\//, 2)
    primary_key = url_parts.first
    
    # first check for festival page
    item = Festival.friendly.find_by_id(primary_key)
    if item.blank?
      item = Page.friendly.find(primary_key)
      if item.blank?
        item = Event.friendly.find(primary_key)
        if item.blank?
          item = Project.friendly.find(primary_key)
        end
      end
    end
    
    if url_parts.size > 1
      case item.class.to_s
      when "Festival"
        redirect_to festival_page_festival_path(item, url_parts[1])
      when "Page"
        redirect_to page_path(params[:url])
      when "Event"
        redirect_to event_path(item)
      when "Project"
        redirect_to project_path(item)
      else
        die
      end
    else
      redirect_to item
    end
    
  end
  
  private

  # def after_sign_in_path_for(resource)
  #   'http://olsof.pixelache.ac/'
  # end
  
  def determine_site
    @site = Subsite.find_by(:name => (request.host =~ /^olsof/ ? 'olsof' : 'pixelache'))
    if @site.name =='olsof'
      @calendar = Event.by_site(@site).where(['start_at >= ? OR end_at >= ?', Time.now, Time.now])
      @calendar += Step.by_site(@site).where(['start_at >= ? OR end_at >= ?', Time.now, Time.now])
    end
    @site.name 
  end
  
  def get_locale 
    if params[:locale]
      session[:locale] = params[:locale]
    end
    
    if session[:locale].blank?
      available  = %w{en fi fr}
      I18n.locale = http_accept_language.compatible_language_from(available)
    else
      I18n.locale = session[:locale]
    end
  end



  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_token, :remember_created_at, :sign_in_count) }
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :username, :email,  authentications_attributes: [:id, :provider, :username ], role_ids: [] )}    
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :name, :username, :password_confirmation, authentications_attributes: [:id, :provider, :username ] ) }
  end
  
end
