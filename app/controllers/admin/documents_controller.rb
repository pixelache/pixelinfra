class Admin::DocumentsController < Admin::BaseController
  skip_load_and_authorize_resource
  
  def create
    @document = Document.create(document_params)
    if @document.save
      flash[:notice] = 'Document created.'
      redirect_to admin_documents_path
    else
      flash[:error] = 'Error creating document: ' + @document.errors.inspect
    end
    
  end
  
  def destroy
    @document = Document.find(params[:id])
    if can? :destroy, @document
      @document.destroy
    end
    redirect_to admin_documents_path
  end
  
  def edit
    @document = Document.find(params[:id])
    unless @document.attachment
      @document.build_attachment
    end
  end
  
  def new
    @document = Document.new
    @document.build_attachment
  end
  
  def index
    @documents = Document.all
  end
  
  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(document_params)
      flash[:notice] = 'Document updated.'
      redirect_to admin_events_path
    else
      flash[:error] = 'Document updating document: ' + @document.errors.inspect
    end
 
  end
  
  protected
  
  def document_params
    params.require(:document).permit(:date_of_release, :subsite_id,   translations_attributes: [:id, :locale, :title, :description], attachment_attributes: [:id, :year_of_publication, :attachedfile,:title, :description, :public, :item_type, :item_id, :documenttype_id,  :_destroy]  )
  end 
  
end
