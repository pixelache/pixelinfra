class Admin::OpencallsController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  skip_load_and_authorize_resource
  
  def create
    @opencall = Opencall.new(opencall_params)
    if @opencall.save
      flash[:notice] = 'Open call saved.'
      redirect_to admin_opencalls_path
    end
  end
  
  
  def destroy
    @opencall = Subsite.find(params[:subsite_id]).pages.find(params[:id])
    @opencall.destroy!
    redirect_to admin_opencalls_path
  end
  
  def new
    @opencall = Opencall.new
  end
    
  def edit
    @opencall = Opencall.friendly.find(params[:id])
  end

  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "LOWER(slug) #{direction}"
      when "active"
        "is_open #{direction}, start_at #{direction}"
      else
        "updated_at DESC"
      end
    end
    @opencalls = apply_scopes(Opencall).includes(:subsite).order(order).page(params[:page]).per(30)
  end

  def update
    @opencall = Opencall.friendly.find(params[:id])
    if @opencall.update(opencall_params)
      flash[:notice] = 'Open call updated.'
      redirect_to admin_opencalls_path
    else
      flash[:error] = 'Error updating open call: ' + @opencall.errors.inspect
    end
 
  end
  

  
  protected
  
  def opencall_params
    params.require(:opencall).permit([:published, :name, :subsite_id, :is_open, :slug,  :closing_date, :page_id, :submitted_text,
    translations_attributes: [:id, :locale, :description],
      opencallquestions_attributes: [ :id, :character_limit, :question_type, :is_required, :_destroy,
        translations_attributes: [:question_text, :id, :locale, :_destroy]
      ]        
     ])
  end
  
end