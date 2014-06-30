class PagesController < InheritedResources::Base
  
  actions :index, :show
  
  def show
    @page = @site.pages.published.find(params[:id])
    if @page.root == @page && @page.root.festival
      redirect_to festival_path(@page.root.festival)
    end
  end
  
end