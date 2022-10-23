class Admin::DocumenttypesController < Admin::BaseController
  skip_load_and_authorize_resource
  load_and_authorize_resource
  
  def create
    @documenttype = Documenttype.new(documenttype_params)
    if @documenttype.save
      flash[:notice] = 'Document type created.'
      redirect_to admin_documenttypes_path
    else
      flash[:error] = 'Error updating document type: ' + @documenttype.errors.inspect
    end
  end
  
  def index
    @documenttypes = Documenttype.all.order(:name)
  end

  def update
    @documenttype = Documenttype.find(params[:id])
    if @documenttype.update(documenttype_params)
      flash[:notice] = 'Document type updated.'
      redirect_to admin_documenttypes_path
    else
      flash[:error] = 'Error updating Document type: ' + @documenttype.errors.inspect
    end
  end

  def edit
    @documenttype = Documenttype.find(params[:id])
  end

  def new
    @documenttype = Documenttype.new
  end
 
  
  protected
  
  def documenttype_params
    params.require(:documenttype).permit(:name, :parent_id)
  end
    
end 