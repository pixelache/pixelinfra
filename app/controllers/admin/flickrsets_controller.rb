class Admin::FlickrsetsController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  autocomplete :event, :name, :extra_data => [:start_at], :display_value => :event_with_date
  skip_load_and_authorize_resource
  load_and_authorize_resource

  def create
    @flickrset = Flickrset.new(flickrset_params)
    if @flickrset.save
      flash[:notice] = 'Flickr set created.'
      redirect_to admin_flickrsets_path
    else
      flash[:error] = 'Error updating flickr set: ' + @flickrset.errors.inspect
    end
  end
  
  def edit
    @flickrset = Flickrset.find(params[:id])
  end

  def new
    @flickrset = Flickrset.new(subsite_id: 1)
  end

  def index
    order = sortable_column_order do |column, direction|
      case column
      when "title"
        "LOWER(title) #{direction}"
      when "last_modified_date"
        "last_modified_date #{direction}"
      when "site"
        "subsites.name #{direction}"
      else
        "last_modified_date DESC"
      end
    end
    @flickrsets = apply_scopes(Flickrset).includes(:subsite).order(order).page(params[:page]).per(30)      
  end
  
  def update
    @flickrset = Flickrset.find(params[:id])
    if @flickrset.update(flickrset_params)
      flash[:notice] = 'Flickr set updated.'
      redirect_to admin_flickrsets_path
    else
      flash[:error] = 'Error updating flickr set: ' + @flickrset.errors.inspect
    end
  end
  
  protected
  
  def flickrset_params
    params.require(:flickrset).permit(:subsite_id, :project_id, :flickr_id, :flickr_user, :title, :description, :event_id, :festival_id)
  end
  
end