class EtherpadsController < InheritedResources::Base
  actions :index
  
  def index
    @etherpads = Etherpad.not_private.order("lower(name)")
  end
end