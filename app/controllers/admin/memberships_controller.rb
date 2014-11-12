class Admin::MembershipsController < Admin::BaseController
  
  def create
    create! { admin_memberships_path }
  end
  
  def update
    update! { admin_memberships_path }
  end
  
  def edit
    @membership = Membership.find(params[:id])
    set_meta_tags :title => t(:edit_membership)
  end
  
  def new
    @membership = Membership.new
    set_meta_tags :title => t(:new_membership)
  end
  
  protected
  
  def permitted_params
    params.permit(:membership => [:user_id, :year, :hallitus, :paid, :hallitus_alternate, :notes])
  end
  
end