class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :force_english
  before_filter :fix_subdomain unless Rails.env.development?
  before_filter :authenticate_user!
  #load_and_authorize_resource
  # check_authorization
  load_and_authorize_resource  :find_by => :slug
#  skip_before_filter :require_no_authentication
  before_filter :set_meta_tagz
  
  def fix_subdomain
    if Rails.env.production?
      unless request.host == 'pixelache.ac' 
        redirect_to host: 'pixelache.ac' and return
      end
    end
  end
  
  def force_english
    I18n.locale = 'en'
  end
  
  def set_meta_tagz
    set_meta_tags :title => params[:controller].gsub(/admin\//, '').humanize
  end
  
  def check_permissions
    authorize! :create, resource
  end
  
  def home

  end

end
