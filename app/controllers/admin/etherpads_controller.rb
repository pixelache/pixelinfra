class Admin::EtherpadsController < Admin::BaseController

  has_scope :by_festival
  has_scope :by_project
  has_scope :by_subsite
  handles_sortable_columns
  autocomplete :event, :name, :extra_data => [:start_at], :display_value => :event_with_date
  
  def destroy
    @etherpad = Etherpad.find(params[:id])
    unless @etherpad.nil?
      ether = EtherpadLite.connect('http://pad.pixelache.ac', ENV['ETHERPAD_API_KEY'], '1.2.1')
      pad = ether.pad(@etherpad.name)
      pad.delete
    end
    @etherpad.destroy
    redirect_to admin_etherpads_path
  end
  
  def update
    update! { admin_etherpads_path }
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
    @etherpads = apply_scopes(Etherpad).all.order(order)
  end
  
  protected
  
  def permitted_params
    params.permit(:etherpad => [:name, :private_pad,  :event_name, subsite_ids: [], project_ids: [], festival_ids: [], event_ids: [] ])
  end
  
end