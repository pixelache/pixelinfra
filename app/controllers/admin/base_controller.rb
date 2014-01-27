class Admin::BaseController < InheritedResources::Base
  layout 'admin'

  before_filter :authenticate_user!
  #load_and_authorize_resource
  # check_authorization
  load_and_authorize_resource :find_by => :slug
  skip_before_filter :require_no_authentication
 
 
  def check_permissions
    authorize! :create, resource
  end
  
  def home

  end

end
