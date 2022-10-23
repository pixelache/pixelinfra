class Admin::SubsitesController < Admin::BaseController
  skip_load_and_authorize_resource
  
  def create
    @subsite = Subsite.new(subsite_params)
    if @subsite.save
      flash[:notice] = 'Subsite created.'
      redirect_to admin_subsites_path
    else
      flash[:error] = 'Error saving subsite: ' + @subsite.errors.full_messages
    end
  end
  
  def new
    @subsite = Subsite.new
  end
  
  def edit
    @subsite = Subsite.find(params[:id])
  end
  
  def update
    @subsite = Subsite.find(params[:id])
    if @subsite.update(subsite_params)
      flash[:notice] = 'Subsite updated.'
      redirect_to admin_subsites_path
    else
      flash[:error] = 'Error saving subsite: ' + @subsite.errors.full_messages
    end
  end
  
  def index
    @subsites = Subsite.all
  end
  
  def destroy
    @subsite = Subsite.find(params[:id])
    if @subsite.destroy
      flash[:notice] = 'Subsite deleted.'
      redirect_to admin_subsites_path
    end
  end
  protected
  
  def subsite_params
    params.require(:subsite).permit(:name, :description, :subdomain)
  end
  
end
