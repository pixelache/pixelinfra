class Admin::PagesController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  has_scope :page, :default => 1
  has_scope :festivals, type: :boolean
  has_scope :projects, type: :boolean
  has_scope :by_subsite
  has_scope :published
  has_scope :unlinked, type: :boolean
  has_scope :by_name
  has_scope :by_slug

  autocomplete :project, :name, :extra_data => [:name], :display_value => :name
  autocomplete :festival, :name, :extra_data => [:name], :display_value => :name
  autocomplete :page, :name, :extra_data => [:name], :display_value => :name
  autocomplete :page, :slug, :extra_data => [:slug], :display_value => :slug
  
  skip_load_and_authorize_resource
  load_and_authorize_resource
  
  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = 'Page saved.'
      redirect_to admin_pages_path
    end
  end
  
  
  def destroy
    @page = Subsite.find(params[:subsite_id]).pages.find(params[:id])
    @page.destroy!
    redirect_to admin_pages_path
  end
  
  def edit
     
    @page = Subsite.find(params[:subsite_id]).pages.find(params[:id])
  end
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "id"
        "id #{direction}"
      when "created"
        "created_at #{direction}"
      when "updated"
        "pages.updated_at #{direction}"
      when "published"
        "published #{direction}, updated_at #{direction}"
      when "site"
        "subsites.name #{direction}"
      when "slug"
        "slug #{direction}"
      else
        "child_updated_at DESC"
      end
    end
    if params[:by_name] || params[:by_slug]
      @pages = apply_scopes(Page).includes(:subsite).order(order).page(params[:page]).per(20)
    else
      @pages = apply_scopes(Page).order(order).roots.includes(:subsite).page(params[:page]).per(20)

    end
  end
  
  def new
    @page = Page.new
  end
  
  def options
    @pages = Page.roots.includes(:subsite).order('created_at DESC').page(params[:page]).per(70)  
    render :layout => false
  end
  
  def order
    @page = Page.find(params[:id])
  end
  
  def sort
    @pages = Page.all
    @pages.each do |fi|
      next if params['page'].index(fi.id.to_s).nil?
      fi.sort_order = params['page'].index(fi.id.to_s) + 1
      fi.save
    end
    head :ok, content_type: "text/html"
  end
  
  def update
    @page = Subsite.find(params[:subsite_id]).pages.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = 'Page updated.'
      redirect_to admin_pages_path
    else
      flash[:error] = 'Error updating page: ' + @page.errors.inspect
    end
 
  end
  
  protected
  
  def page_params
    params.require(:page).permit( [:published, :slug, :festival_id, :parent_id, :festival_name, 
      :project_name, :project_id, :subsite_id, :opencall_id,
       subsite_ids: [], translations_attributes: [:id, :locale, :name, :body],
        photos_attributes: [:id, :filename, :title, :credit, :_destroy],
        festivaltheme_ids: []] )
  end
  
end