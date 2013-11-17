class Admin::PagesController < Admin::BaseController
  
  def create
    create! { admin_pages_path }
  end
  
  def update
    update! { admin_pages_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:page => [:published, :slug, :subsite_id, translations_attributes: [:id, :locale, :name, :body]])
  end
  
end