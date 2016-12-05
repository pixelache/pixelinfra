class NodesController < ApplicationController
  
  def index
    @nodes = Node.all
  end
  
  def show
    @node = Node.friendly.find(params[:id])
  end
  
end