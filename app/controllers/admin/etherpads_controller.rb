class Admin::EtherpadsController < Admin::BaseController

  has_scope :by_festival
  has_scope :by_project
  has_scope :by_subsite
  has_scope :by_event
  has_scope :by_meeting
  has_scope :by_documenttype
  handles_sortable_columns
  autocomplete :event, :name, :extra_data => [:start_at], :display_value => :event_with_date
  skip_load_and_authorize_resource
  load_and_authorize_resource

  def edit
    @etherpad = Etherpad.find(params[:id])
  end
  
  def destroy
    @etherpad = Etherpad.find(params[:id])
    unless @etherpad.nil?
      server = @etherpad.archived ? 'https://pad.archive.pixelache.ac' : 'https://pad.pixelache.ac' 
      key =  @etherpad.archived ? ENV['ETHERPAD_ARCHIVE_KEY'] : ENV['ETHERPAD_API_KEY']
      ether = EtherpadLite.connect(server, key, '1.2.15')
      pad = ether.pad(@etherpad.name)
      pad.delete
    end
    @etherpad.destroy
    redirect_to admin_etherpads_path
  end
  
  def update
    @etherpad = Etherpad.find(params[:id])
    if @etherpad.update(etherpad_params)
      flash[:notice] = 'Pad updated.'
      redirect_to admin_etherpads_path
    else
      flash[:error] = 'Error updating etherpad.'
    end
 
  end
  
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "lower(name) #{direction}"
      when "last_edited"
        "#{column} #{direction}, lower(name) ASC"
      else
        "last_edited DESC"
      end
    end
    @etherpads = apply_scopes(Etherpad).all.order(order).page(params[:page]).per(100)
    @etherpad_events = @etherpads.map(&:events).flatten.compact
  end
  
  protected
  
  def etherpad_params
    params.require(:etherpad).permit(:name, :private_pad,  :event_name, :documenttype_id, subsite_ids: [], meeting_ids: [],  project_ids: [], festival_ids: [], event_ids: [] )
  end
  
end