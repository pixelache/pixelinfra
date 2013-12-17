class Admin::PagesController < Admin::BaseController
  has_scope :page, :default => 1
  
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
    @pages = Page.roots.order(:slug).page(params[:page]).per(20)
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