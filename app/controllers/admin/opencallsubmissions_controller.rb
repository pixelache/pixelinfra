class Admin::OpencallsubmissionsController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "id"
        "id #{direction}"
      when "name"
        "LOWER(name) #{direction}"
      when "when"
        "created_at #{direction}"
      when "comments"
        "comment_count #{direction}"
      else
        "created_at DESC"
      end
    end
    @opencall = Opencall.friendly.find(params[:opencall_id])
    @submissions = @opencall.opencallsubmissions.order(order)
  end
  
  def show
    if params[:opencall_id].nil?
      @submission = Opencallsubmission.find(params[:id])
      redirect_to admin_opencall_opencallsubmission_path(@submission.opencall, @submission) 
    else
      @opencall = Opencall.friendly.find(params[:opencall_id])
      @submission = Opencallsubmission.find(params[:id])
    end
  end
end
