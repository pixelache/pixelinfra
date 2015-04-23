class Admin::StepsController < Admin::BaseController
  autocomplete :event, :name, :extra_data => [:start_at], :display_value => :event_with_date
  autocomplete :festival, :name
    
  def create
    create! { admin_steps_path }
  end
  
  def update
    update! { admin_steps_path }
  end
  
  def destroy
    destroy! { admin_steps_path }
  end
    
  protected
  
  def permitted_params
    params.permit(:step => [:subsite_id, :festival_id, :node_id, :description, :start_at, :end_at, :name, :number, :event_id, :slug])
  end
    
end 