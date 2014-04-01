class Admin::DynamictaglinesController < Admin::BaseController
  
  def create
    create! { admin_dynamictaglines_path }
  end
  
  def update
    update! { admin_dynamictaglines_path}
  end
  
  def index
    @dynamictagline = Dynamictagline.find_or_create_by(:subsite_id => @site.id)
  end
  
  protected
  
  def permitted_params
    params.permit(:dynamictagline => [:festival, :electronic, :art, :subcultures])
  end
end
  