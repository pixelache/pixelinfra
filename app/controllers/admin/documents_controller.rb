class Admin::DocumentsController < Admin::BaseController

  def create
    create! { admin_documents_path }
  end
  
  def new
    @document = Document.new
    @document.build_attachment
  end
  
  def update
    update! { admin_documents_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:document => [ :date_of_release, :subsite_id,   translations_attributes: [:id, :locale, :title, :description], attachment_attributes: [:id, :year_of_publication, :attachedfile,:title, :description, :public, :item_type, :item_id, :documenttype_id,  :_destroy]  ] )
  end 
  
end
