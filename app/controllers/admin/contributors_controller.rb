class Admin::ContributorsController < Admin::BaseController


  def show
    @contributor = Contributor.friendly.find(params[:id])
  end
    
  def edit
    @contributor = Contributor.friendly.find(params[:id])
    
  end
  
  def new
    @contributor = Contributor.new
  end
  
  def index
    @contributors = Contributor.all.order(:alphabetical_name).page(params[:page]).per(30)
  end
  
  def create
    @contributor = Contributor.new(contributor_params)
    if @contributor.save
      flash[:notice] = 'Contributor created.'
      redirect_to admin_contributors_path
    else
      flash[:error] = 'Error saving contributor.'
      render template: 'admin/contributors/new'
    end
  end
  
  def update
    @contributor = Contributor.friendly.find(params[:id])
    if @contributor.update_attributes(contributor_params)
      flash[:notice] = 'Contributor updated.'
      redirect_to admin_contributors_path
    else
      flash[:error] = 'Error updating contributor.'
      render template: 'admin/contributors/edit'
    end
 
  end
  
  def destroy
    @contributor = Contributor.friendly.find(params[:id])
    if can? :destroy, @contributor
      if @contributor.destroy
        flash[:notice] = 'Contributor deleted.'
      else
        flash[:error] = 'There was an error removing this contributor.' 
      end
    else
      flash[:notice] = 'you do not have permission for this'
    end
    redirect_to admin_contributors_path
  end
  
 
    

  
  protected
  
  def contributor_params
    params.require(:contributor).permit(:name, :slug, :parent_id, :image, :alphabetical_name, :bio, :website, :is_member, :user_id, attachments_attributes: [:id, :attachedfile, :event_id, :_destroy],project_ids: [], event_ids: [], festival_ids: [], festivaltheme_ids: [], residency_ids: [])
  end
    
end 