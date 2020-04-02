class PagesController < ApplicationController
  
  def show
    if params[:id] =~ /\//
      p = params[:id].split(/\//).last
    else
      p = params[:id]
    end

    if params[:project_id]
      if @site && @site.id != 1
        redirect_to host: 'pixelache.ac' and return
      else
        @project = Project.friendly.find(params[:project_id])
        @page = Page.friendly.find(params[:id])
        @page = Page.friendly.find(params[:page]) if params[:page]
        set_meta_tags :title => @project.name + " - " + @page.name
        render :template => 'projects/page'
      end
    else
      if params[:id] =~ /^\d*$/
        @page = Page.find(params[:id])
      end
      if user_signed_in?
        pages = @site.pages.where(slug: p)
      else
        pages = @site.pages.published.where(slug: p)
      end
      if pages.size == 1 && pages.first.root?
        if pages.first.festival
          redirect_to pages.first.festival
        end
      end
      if pages.roots.empty?
        if pages.empty? && !@page.nil?
          @page = @page
        else
          @page = pages.first
        end
        if @page.nil?
          raise ActiveRecord::RecordNotFound
        end
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
    if @page.opencall
      @opencall = @page.opencall
      @opencallsubmission = Opencallsubmission.new(opencall: @opencall)
      @opencall.opencallquestions.sort_by(&:created_at).each do |qs|
        @opencallsubmission.opencallanswers.build(opencallquestion: qs)
      end
    end
    # redirect_to action: action_name, id: @page.friendly_id, status: 301 unless @page.friendly_id == params[:id]
    set_meta_tags :title => @page.name,
                      canonical: url_for(@page),
                      og: {image: (!@page.photos.empty? ?  [ @page.photos.first.filename.url(:box), { secure_url: @page.photos.first.filename.url(:box) } ] : 'https://pixelache.ac/assets/pixelache/images/PA_logo.png'), 
                            title: @page.title, type: 'website', url: url_for(@page),
                            description: ActionView::Base.full_sanitizer.sanitize(@page.body.nil? ? @page.title : @page.body[0..500]) 
                          }, 
                      twitter: {card: 'summary', site: '@pixelache'}
    respond_to do |format|
      format.html
      format.json { render json: PageSerializer.new(@page).serialized_json, status: 200 }
    end
  end
  
end