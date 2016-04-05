class Admin::OpencallsController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns

  def create
    create! { admin_opencalls_path }
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
    update! { admin_opencalls_path }
  end
  
  def destroy
    destroy! { admin_opencalls_path }
  end
  

  
  protected
  
  def opencall_params
    params.require(:opencall).permit([:published, :name, :subsite_id, :is_open, :page_id, :submitted_text,
      opencallquestions_attributes: [ :id, :character_limit, :question_type, :is_required, :_destroy,
        translations_attributes: [:question_text, :id, :locale, :_destroy]
      ]        
     ])
  end
  
end