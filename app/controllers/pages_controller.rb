class PagesController < InheritedResources::Base
  
  actions :index, :show
  
  def show
    if params[:id] =~ /\//
      p = params[:id].split(/\//).last
    else
      p = params[:id]
    end
    
    @page = @site.pages.published.find(p)
    set_meta_tags :title => @page.name
    if @page.root == @page && @page.root.festival
      redirect_to festival_path(@page.root.festival)
    elsif @page.root == @page && @page.root.project
      redirect_to project_path(@page.root.project)
    elsif @page.root != @page && @page.root.festival
      redirect_to festival_page_festival_path(@page.root.festival, @page.id)
    end
    
  end
  
end