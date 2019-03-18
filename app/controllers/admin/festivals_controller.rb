class Admin::FestivalsController < Admin::BaseController
  # autocomplete :place, :name
  handles_sortable_columns
  skip_load_and_authorize_resource
  
  def edit
    @festival = Festival.friendly.find(params[:id])
    
  end
  
  def new
    @festival = Festival.new
  end
  

  
  def create
    @festival = Festival.new(festival_params)
    if @festival.save
      flash[:notice] = 'Festival created.'
      redirect_to admin_festivals_path
    else
      flash[:error] = 'Error saving festival.'
    end
  end
  
  def update
    @festival = Festival.friendly.find(params[:id])
    if @festival.update_attributes(festival_params)
      flash[:notice] = 'Festival updated.'
      redirect_to admin_festivals_path
    else
      flash[:error] = 'Error updating festival.'
    end
 
  end
  
  def destroy
    @festival = Festival.friendly.find(params[:id])
    if @festival.destroy
      flash[:notice] = 'Festival deleted.'
    end
    redirect_to admin_festivals_path
  end
  
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "name #{direction}"
      when "dates"
        "start_at #{direction}"
      else
        "start_at"
      end
    end
    @festivals = apply_scopes(Festival).includes(:node).order(order).page(params[:page]).per(20)
  end

  def show
    @festival = Festival.friendly.find(params[:id])
  end
  
  def subscribe
    @festival = Festival.find(params[:id])
    @festival.subscribe_to_list(current_user)
    redirect_to [:admin, @festival]
  end
  
    
  def subscribe_other
    @festival = Festival.find(params[:id])
    email = params[:email]
    # not elegant but will fix later
    if User.find_by(email: params[:email]).nil?
      @festival.subscribe_to_list(params[:email])
 
    else
      @festival.subscribe_to_list(User.find_by(email: params[:email]))
    end
    redirect_to admin_festival_path(@festival)
  end
  
  
  def toggle_list
    @festival = Festival.find(params[:id])

    current_user.subscribed_to?(@festival) ? @festival.unsubscribe_from_list(current_user) :     @festival.subscribe_to_list(current_user)
    @status = current_user.subscribed_to?(@festival)
    respond_to do |format|
      format.js 
    end
  end
  
  def unsubscribe
    @festival = Festival.find(params[:id])
    @festival.unsubscribe_from_list(current_user)
    redirect_to [:admin, @festival]
  end  
  protected
  
  def festival_params
    params.require(:festival).permit(:name, :website, :slug, :start_at, :has_listserv, :subsite_id, :redirect_to, :listservname,
       :festival_location, :tertiary_colour, :remove_festivalbackdrop,  :node_id, :remove_image, :festival_id, :end_at, 
       :background_colour, :primary_colour, :image, :published, :subtitle, :slug, :festivalbackdrop,
        translations_attributes: [:id, :locale, :overview_text], 
         attachments_attributes: [:id, :year_of_publication, :attachedfile, :title, :description, :public, :item_type, :item_id, :documenttype_id,  :_destroy], videos_attributes: [:id, :in_url, :_destroy] )
  end
    
end 