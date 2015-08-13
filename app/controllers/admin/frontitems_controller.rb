class Admin::FrontitemsController < Admin::BaseController
  autocomplete :post, :title, :extra_data => [:published, :published_at], :display_value => :name_with_date
  autocomplete :page, :name, :extra_data => [:name], :display_value => :name
  autocomplete :event, :name, :extra_data => [:name], :display_value => :name
  autocomplete :project, :name, :extra_data => [:name], :display_value => :name
  autocomplete :festival, :name, :extra_data => [:name], :display_value => :name
  autocomplete :residency, :name, :extra_data => [:name], :display_value => :name
  # has_scope :by_site , default: 1
  
  def create
    create! { admin_frontitems_path }
  end
  
  def edit
    @frontitems = Frontitem.find(params[:id])
  end
  
  def index
    @frontitems = apply_scopes(Frontitem).all
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
    params.permit(:frontitem => [:item_type, :subsite_id, :seconditem_type, :dont_scale, :no_text, :external_url, :seconditem_id, :custom_title, :item_id, :frontmodule_id, :position, :custom_follow_text, :external_url, :remove_bigimage, :background_colour, :bigimage, :background_on_title, :background_on_text, 
      :text_colour, :active, translations_attributes: [:id, :locale, :custom_title, :custom_follow_text]])
    
  end
end