class PagesController < InheritedResources::Base
  
  actions :index, :show
  
  def show
    @page = @site.pages.published.find(params[:id])
    set_meta_tags :title => @page.name
    if @page.root == @page && @page.root.festival
      redirect_to festival_path(@page.root.festival)
    elsif @page.root != @page && @page.root.festival
      redirect_to festival_path_page(@page.root.festival, @page)
    end
    
  end
  
end