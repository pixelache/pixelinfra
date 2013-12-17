class Admin::PagesController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  
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
    @pages = Page.roots.includes(:subsite).order(order).page(params[:page]).per(20)
  end
  
  def update
    @page = Subsite.find(params[:page][:subsite_id]).pages.find(params[:id])
    update! { admin_pages_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:page => [:published, :slug, :subsite_id, subsite_ids: [], translations_attributes: [:id, :locale, :name, :body] ] )
  end
  
end