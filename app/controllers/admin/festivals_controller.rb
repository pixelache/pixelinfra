class Admin::FestivalsController < Admin::BaseController
  # autocomplete :place, :name
  handles_sortable_columns
  
  
  def create
    create! { admin_festivals_path }
  end
  
  def update
    update! { admin_festivals_path }
  end
  
  def destroy
    destroy! { admin_festivals_path }
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
  
  def permitted_params
    params.permit(:festival => [:name, :website, :slug, :start_at, :has_listserv, :listservname, :festival_location, :tertiary_colour, :node_id, :remove_image, :festival_id, :end_at, :background_colour, :primary_colour, :image, :published, :subtitle, :slug, :festivalbackdrop, translations_attributes: [:id, :locale, :overview_text],  attachments_attributes: [:id, :attachedfile,:title, :description, :public, :item_type, :item_id, :documenttype_id,  :_destroy]] )
  end
    
end 