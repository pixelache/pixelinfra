class Admin::ResidenciesController < Admin::BaseController
  has_scope :page, :default => 1
  
  def create
    @residency = Residency.new(residency_params)
    if @residency.save
      flash[:notice] = 'Residency created.'
      redirect_to admin_residencies_path
    else
      flash[:error] = 'Error updating residency: ' + @residency.errors.inspect
    end
  end

  def edit
    @residency = Residency.friendly.find(params[:id])
  end
  
  def index
    @residencies = Residency.order(start_at: :desc).page(params[:page]).per(30)
  end
  
  def new
    @residency = Residency.new
  end

  def update
    @residency = Residency.friendly.find(params[:id])
    if @residency.update(residency_params)
      flash[:notice] = 'Residency updated.'
      redirect_to admin_residencies_path
    else
      flash[:error] = 'Error updating residency: ' + @residency.errors.inspect
    end
  end
  
  protected
  
  def residency_params
    params.require(:residency).permit(:name, :country, :start_at, :country_override, :end_at, :is_micro, :slug, :photo, :project_id, :user_id,  translations_attributes: [:id, :locale, :description])
  end
  
end