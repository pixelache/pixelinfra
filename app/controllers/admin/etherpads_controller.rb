class Admin::EtherpadsController < Admin::BaseController

  has_scope :by_festival
  has_scope :by_project
  has_scope :by_subsite
  
  def update
    update! { admin_etherpads_path }
  end
  
  def index
    @etherpads = apply_scopes(Etherpad).all
  end
  
  protected
  
  def permitted_params
    params.permit(:etherpad => [ subsite_ids: [], project_ids: [], festival_ids: [] ])
  end
  
end