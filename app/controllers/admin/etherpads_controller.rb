class Admin::EtherpadsController < Admin::BaseController

  has_scope :by_festival
  has_scope :by_project
  has_scope :by_subsite
  
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
    @etherpads = apply_scopes(Etherpad).all.order('lower(name)')
  end
  
  protected
  
  def permitted_params
    params.permit(:etherpad => [:name, :private_pad,  subsite_ids: [], project_ids: [], festival_ids: [] ])
  end
  
end