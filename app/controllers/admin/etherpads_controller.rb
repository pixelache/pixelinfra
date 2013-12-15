class Admin::EtherpadsController < Admin::BaseController

  def update
    update! { admin_etherpads_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:etherpad => [ subsite_ids: [], project_ids: []])
  end
  
end