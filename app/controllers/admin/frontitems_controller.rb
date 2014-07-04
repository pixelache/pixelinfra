class Admin::FrontitemsController < Admin::BaseController
  autocomplete :post, :title, :extra_data => [:published, :published_at], :display_value => :name_with_date
  autocomplete :page, :name
  
  def create
    create! { admin_frontitems_path }
  end
  
  def sort
    @frontitems = Frontitem.all
    @frontitems.each do |fi|
      next if params['frontitem'].index(fi.id.to_s).nil?
      fi.position = params['frontitem'].index(fi.id.to_s) + 1
      fi.save
    end
    render nothing: true
  end
  
  def update
    update! { admin_frontitems_path }
  end
  
  protected 
  
  def permitted_params
    params.permit(:frontitem => [:item_type, :subsite_id, :seconditem_type, :seconditem_id, :custom_title, :item_id, :frontmodule_id, :position, :custom_follow_text, :external_url, :remove_bigimage, :background_colour, :bigimage, :text_colour, :active])
    
  end
end