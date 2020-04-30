class Admin::FrontitemsController < Admin::BaseController
  autocomplete :post, :title, :extra_data => [:published, :published_at], :display_value => :name_with_date
  autocomplete :page, :name, :extra_data => [:name], :display_value => :name
  autocomplete :event, :name, :extra_data => [:name], :display_value => :name
  autocomplete :project, :name, :extra_data => [:name], :display_value => :name
  autocomplete :festival, :name, :extra_data => [:name], :display_value => :name
  autocomplete :residency, :name, :extra_data => [:name], :display_value => :name
  has_scope :by_site, default: 1
  skip_load_and_authorize_resource
  load_and_authorize_resource
  
  def create
    @frontitem = Frontitem.new(frontitem_params)
    @frontitem.subsite_id = 1
    if @frontitem.save
      flash[:notice] = 'New frontpage item saved.'
      redirect_to admin_frontitems_path
    else
      flash[:error] = @frontitem.errors.inspect
      render template: 'admin/frontitems/new'
    end
  end
  
  
  def destroy
    @frontitem = Frontitem.find(params[:id])
    @frontitem.destroy!
    redirect_to admin_frontitems_path
  end
  
  
  def update
    @frontitem = Frontitem.find(params[:id])
    if @frontitem.update_attributes(frontitem_params)
      flash[:notice] = 'Open call updated.'
      redirect_to admin_frontitems_path
    else
      flash[:error] = 'Error updating front item: ' + @frontitem.errors.inspect
    end

  end
  
  def new
    @frontitem = Frontitem.new(subsite_id: 1)

  end
    

  def edit
    @frontitem = Frontitem.find(params[:id])
  end
  
  def index
    # @frontitems = apply_scopes(Frontitem).all
    @frontitems = Frontitem.by_site(1)
    @by_site = 1
  end
  
  def sort
    @frontitems = Frontitem.all
    @frontitems.each do |fi|
      next if params['frontitem'].index(fi.id.to_s).nil?
      fi.position = params['frontitem'].index(fi.id.to_s) + 1
      fi.save
    end
    head :ok, content_type: "text/html"
  end

  
  protected 
  
  def frontitem_params
    params.require(:frontitem).permit(:item_type, :item_name, :seconditem_name, :rawhtml, :subsite_id, :seconditem_type, :dont_scale, :no_text, :external_url, :seconditem_id, :custom_title, :item_id, :frontmodule_id, :position, :custom_follow_text, :external_url, :remove_bigimage, :background_colour, :bigimage, :background_on_title, :background_on_text, 
      :text_colour, :active, translations_attributes: [:id, :locale, :custom_title, :custom_follow_text])
    
  end
end