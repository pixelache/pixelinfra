class PagesController < InheritedResources::Base
  
  actions :index, :show
  
  def show
    if params[:id] =~ /\//
      p = params[:id].split(/\//).last
    else
      p = params[:id]
    end

    if params[:project_id]
      @project = Project.find(params[:project_id])
      @page = Page.find(params[:id])
      @page = Page.find(params[:page]) if params[:page]
       set_meta_tags :title => @project.name + " - " + @page.name
      render :template => 'projects/page'
    else
      pages = @site.pages.published.where(slug: p)

      if pages.size == 1 && pages.first.root?
        if pages.first.festival
          redirect_to pages.first.festival
        end
      end
      if pages.roots.empty?
        @page = pages.first
        if @page.has_project?
          redirect_to project_page_path(:project_id => @page.parent_project)
        else
          set_meta_tags :title => @page.name
          if @page.root == @page && @page.root.festival
            redirect_to festival_path(@page.root.festival)
          elsif @page.root == @page && @page.root.project
            redirect_to project_page_path(@page.root.project, @page)
          elsif @page.root != @page && @page.root.festival
            redirect_to festival_page_festival_path(@page.root.festival, @page.id)
          end
        end
      else
        @page = pages.roots.first
      end
    end
    set_meta_tags :title => @page.name
  end
  
end