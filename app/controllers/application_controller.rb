class ApplicationController < ActionController::Base
  protect_from_forgery
  include ThemesForRails::ActionController 
  theme :determine_site
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_locale
  # before_action :populate_nav
  before_action :set_paper_trail_whodunnit
  # rescue_from StandardError, :with => :render_500 unless Rails.env.development?

  rescue_from ActiveRecord::RecordNotFound, with: :render_404 unless Rails.env.development?

  def render_404(exception)
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  def render_500(exception)
    @exception = exception
    logger.debug 'exception is ' + @exception.inspect
    render :template => "application/500", :status => 500

  end
  
  
  def add_to_mailchimp  # change when we get API key
    h = Gibbon::Request.new({:api_key => ENV['mailchimp_api_key']})
    # list =
    begin
      h.lists(ENV['mailchimp_list_id']).members.create(body: {email_address: params[:email].strip, status: "subscribed" })
      @signup_success = t(:thanks_signup)
      @signup_error = nil
    rescue
      @signup_error = t(:error_adding_email)
    end
    respond_to do |format|
        format.js {render :partial => 'shared/email_signup', :content_type => 'text/javascript'}
    end
  end
  
  def populate_nav
    # if @site.name == 'empathy'
    #   protect_with_staging_password
    # end
    return if @site.name != 'pixelache'

    return if request.fullpath =~ /^admin/
    @recent_events = Event.by_site(@site).published.order('start_at DESC').limit(3)
    @active_projects = Project.active.order_by_rand.limit(7)
    @recent_festivals =  Festival.by_node(@site.id).published.order('end_at desc').limit(3)
    @recent_news = Post.by_site(@site).published.order('published_at DESC').limit(3)
  end
  
  def reroute
    url_parts = params[:url].split(/\//, 2)
    primary_key = url_parts.first
    
    if url_parts.first == 'feed'
      redirect_to feeds_path, format: :rss
    else
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
  end
  

  def not_found
    if params[:unmatched_route] =~ /\//
      splits = params[:unmatched_route].split(/\//)
      first = splits.first
      params[:unmatched_route] = splits.last
    else
      first = params[:unmatched_route]
    end

    # first look for a project
    begin
      @project = Project.find_by_id(params[:unmatched_route])
      unless @project.nil?
        redirect_to @project, :status => :moved_permanently and return
      else
        @page = Page.find_by_id(params[:unmatched_route])
        unless @page.nil?
          if @page.has_project?
            redirect_to project_page_path(:project_id => @page.parent_project.id, id: @page.id), :status => :moved_permanently
          else
            redirect_to @page, :status => :moved_permanently
          end
        else
          render_404(nil)

        end
      end
    end

      #       if !@festival.pages.find(params[:unmatched_route]).empty?
      #         redirect_to festival_page_path(@festival, @festival.pages.find(params[:unmatched_route]).first), :status => :moved_permanently
      #       else
      #         redirect_to @festival, :status => :moved_permanently
      #       end
      #     rescue ActiveRecord::RecordNotFound
      #       if @festival
      #          redirect_to @festival, :status => :moved_permanently
      #       else
      #         render file: "#{Rails.root}/public/404.html", status: 404
      #       end
      #     end
      #   else
      #     render file: "#{Rails.root}/public/404.html", status: 404
      #   end
    #   end
    # end
  end
  
  def protect_with_staging_password
    authenticate_or_request_with_http_basic('Developer only! (for now)') do |username, password|
      username == Figaro.env.staging_username && password == Figaro.env.staging_password
    end
  end
  
  private

  # def after_sign_in_path_for(resource)
  #   'http://olsof.pixelache.ac/'
  # end
  
  def determine_site
    if Rails.env.development?
      if request.host =~ /^empathy/ 
        @site = Subsite.find_by(name: 'empathy')
      else
        @site = Subsite.find_by(subdomain: request.host.gsub(/\.local$/, '')) 
      end
      #@site = Subsite.find_by(name: 'empathy')
    else
      # put LS behind password for now
      if request.host =~ /^livingspaces/

        @site = Subsite.find_by(:name => 'livingspaces')  
      elsif request.host =~ /^documenting/ 
        @site = Subsite.find_by(name: 'documenting')
      elsif request.host =~ /^empathy/ 
        @site = Subsite.find_by(name: 'empathy') 
      elsif   request.host =~ /^festival2017/   
         @site = Subsite.find_by(name: 'festival2017')
      elsif request.host =~ /^breaking5/ || request.host =~ /^festival\./
        @site = Subsite.find_by(name: 'breaking5thwall')
      else
        @site = Subsite.find_by(:name => (request.host =~ /opensourcingfestivals/ || request.host =~ /^olsof\./ ? 'olsof' : 'pixelache'))
      end
    end
    if @site.nil?
      @site = Subsite.first
    end
    if @site.name =='olsof'
      @calendar = Event.by_site(@site).where(['start_at >= ? OR end_at >= ?', Time.now, Time.now])
      @calendar += Step.by_site(@site).where(['start_at >= ? OR end_at >= ?', Time.now, Time.now])
    end
    @site.name
    
  end
  
  def get_locale 
    if params[:locale]
      session[:locale] = params[:locale] if ['en', 'fi'].include?(params[:locale])
    end

    if session[:locale].blank?
      available  = %w{en fi}
      I18n.locale = http_accept_language.compatible_language_from(available)
      session[:locale] = I18n.locale
    else
      I18n.locale = session[:locale]
    end
    if @site.name == 'olsof' 
      I18n.locale = :en
    end

    unless !['en', 'fi'].include?(I18n.locale)
      session[:locale] = 'en'
      I18n.locale = :en
    end

  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_OMNIAUTH_APP_ID']
      config.consumer_secret     = ENV['TWITTER_OMNIAUTH_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end  
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :name, :password, :password_confirmation, :avatar, :remember_created_at, :sign_in_count, :slug, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs

  end

  
end
