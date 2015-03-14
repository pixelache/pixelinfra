class Admin::ArchivalimagesController < Admin::BaseController
  autocomplete :event, :name, :extra_data => [:start_at], :display_value => :event_with_date
  autocomplete :project, :name, :extra_data => [:name]
  autocomplete :festival, :name, :extra_data => [:name]
  
  def create
    create! { admin_archivalimages_path }
  end
  
  def update
    update!  { admin_archivalimages_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:archivalimage => [:image, :subsite_id, :event_name, :cover_right, :event_id,  :project_name, :project_id, :festival_name, :festival_id, :credit, translations_attributes: [:id, :locale, :caption]])
  end
end