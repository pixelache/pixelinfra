class Admin::EventsController < Admin::BaseController
  autocomplete :place, :name
  autocomplete :event, :name
  handles_sortable_columns
  has_scope :by_subsite
  has_scope :by_project
  has_scope :by_festival
  has_scope :by_year
  has_scope :by_name
  skip_load_and_authorize_resource  only: [:index]
  
  def attendees
    @event = Event.friendly.find(params[:id])
    @attendees = @event.attendees.order(:created_at)
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = 'Event created.'
      redirect_to admin_events_path
    else
      flash[:error] = 'Error saving event:' +  @event.errors.inspect
    end
  end
  

    
  def edit
    @event = Event.friendly.find(params[:id])
    unless @event.feeds.empty?
      @event.add_to_newsfeed = true
    end

  end

  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "LOWER(slug) #{direction}"
      when "published"
        "published #{direction}, start_at #{direction}"
      when "when"
        "start_at #{direction}"
      else
        "start_at DESC"
      end
    end
    @events = apply_scopes(Event).includes(:subsite).order(order).page(params[:page]).per(30)
  end

  def update
    @event = Event.friendly.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = 'Event updated.'
      redirect_to admin_events_path
    else
      flash[:error] = 'Error updating event: ' + @event.errors.inspect
    end
 
  end
  
  def destroy
    @event = Event.friendly.find(params[:id])
    if @event.destroy
      flash[:notice] = 'Event deleted.'
    end
    redirect_to admin_events_path
  end
  

  protected
  
  def event_params
    params.require(:event).permit(:subsite_id, :place_id, :start_at, :end_at, :step_id, :published, :image, :image_width, :place_name, :image_height, :image_content_type, :image_size, :residency_id, :facebook_link, :cost, :cost_alternate, :cost_alternate_reason, :project_id, :festival_id, :facilitator_name, :facilitator_url, :facilitator_organisation, :user_id, :add_to_newsfeed, :user_id, :resources_needed, :protocol, :stream_url,
      :facilitator_organisation_url, :tag_list, :technology_list, :location_tbd, :tag_list, :archive_by_contributor,
      :registration_required, :email_registrations_to, :question_description, :external_registration,
      :question_creators, :question_motivation, :require_approval, 
      :hide_registrants, :show_guests_to_public, :max_attendees,
      photos_attributes: [:id, :filename, :filename_content_type, :title, :credit, :_destroy],
      videos_attributes: [:id, :in_url, :_destroy],
      attachments_attributes: [:id, :attachedfile, :event_id, :_destroy],
      contributor_ids: [],
      festivaltheme_ids: [], 
      translations_attributes: [:name, :description, :notes, :id, :locale, :_destroy])
  end
    
end 