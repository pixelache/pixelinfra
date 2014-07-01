class Admin::PagesController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  has_scope :page, :default => 1
  has_scope :festivals, type: :boolean
  has_scope :projects, type: :boolean
  has_scope :by_subsite
  has_scope :published
  has_scope :unlinked, type: :boolean

  autocomplete :project, :name
  autocomplete :festival, :name, :extra_data => [:name], :display_value => :name
  
  def create
    create! { admin_pages_path }
  end
  
  
  def destroy
    @page = Subsite.find(params[:subsite_id]).pages.find(params[:id])
    destroy! { admin_pages_path }
  end
  
  def edit
    @page = Subsite.find(params[:subsite_id]).pages.find(params[:id])
  end
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "id"
        "id #{direction}"
      when "when"
        "updated_at #{direction}"
      when "published"
        "published #{direction}, updated_at #{direction}"
      when "site"
        "subsites.name #{direction}"
      else
        "updated_at DESC"
      end
    end
    @pages = apply_scopes(Page).roots.includes(:subsite).order(order).page(params[:page]).per(20)
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
    render nothing: true      
  end
  
  def update
    @page = Subsite.find(params[:page][:subsite_id]).pages.find(params[:id])
    update! { admin_pages_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:page => [:published, :slug, :festival_id, :parent_id, :festival_name, :project_name, :project_id, :subsite_id, subsite_ids: [], translations_attributes: [:id, :locale, :name, :body] ] )
  end
  
end