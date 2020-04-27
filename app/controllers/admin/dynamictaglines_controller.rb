class Admin::DynamictaglinesController < Admin::BaseController
  skip_load_and_authorize_resource
  load_and_authorize_resource

  def create
    create! { admin_dynamictaglines_path }
  end
  
  def update
    @dynamictagline = Dynamictagline.find(params[:id])
    if @dynamictagline.update(dynamictagline_params)
      flash[:notice] = 'Tagline settings updated'
      redirect_to admin_dynamictaglines_path
    end
  end
  
  def index
    @dynamictagline = Dynamictagline.find_or_create_by(:subsite_id => @site.id)
  end
  
  protected
  
  def dynamictagline_params
    params.require(:dynamictagline).permit(:festival, :electronic, :art, :subcultures)
  end
end
  