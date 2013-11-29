class PagesController < InheritedResources::Base
  
  actions :index, :show
  
  def show
    @page = @site.pages.published.find(params[:id])
  end
  
end