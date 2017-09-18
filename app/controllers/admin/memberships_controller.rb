class Admin::MembershipsController < Admin::BaseController
  skip_load_and_authorize_resource
  load_and_authorize_resource
  
  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      flash[:notice] = 'Membership updated.'
      redirect_to admin_memberships_path
    end      
  end
  
  def update
    @membership = Membership.find(params[:id])
    if @membership.update_attribute(membership_params)
      flash[:notice] = 'Membership updated.'
      redirect_to admin_memberships_path
    end
  end
  
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to admin_memberships_path
  end
  
  def edit
    @membership = Membership.find(params[:id])
    set_meta_tags :title => t(:edit_membership)
  end
  
  def new
    @membership = Membership.new
    set_meta_tags :title => t(:new_membership)
  end
  
  def index
    @memberships = Membership.all.order(year: :desc)
  end
  
  protected
  
  def membership_params
    params.require(:membership).permit(:user_id, :year, :hallitus, :paid, :hallitus_alternate, :notes)
  end
  
end