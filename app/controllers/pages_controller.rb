class PagesController < InheritedResources::Base
  
  actions :index, :show
  
  def show
    @page = Page.friendly.find(params[:id])
  end
  
end