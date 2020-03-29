class Admin::FrontmodulesController < Admin::BaseController
  skip_load_and_authorize_resource
  def create
    @frontmodule = Frontmodule.new(frontmodule_params)
    if @frontmodule.save
      redirect_to admin_frontmodules_path
    end
  end
  
  def edit
    @frontmodule = Frontmodule.find(params[:id])
  end

  def index
    @frontmodules = Frontmodule.all
  end
  
  def new
    @frontmodule = Frontmodule.new
  end

  def update
    @frontmodule = Frontmodule.find params[:id]
    if @frontmodule.update(frontmodule_params)
      redirect_to admin_frontmodules_path
    end
  end
  
  protected 
  
  def frontmodule_params
    params.require(:frontmodule).permit(:name, :partial_name, :exampleimage)
    
  end
end