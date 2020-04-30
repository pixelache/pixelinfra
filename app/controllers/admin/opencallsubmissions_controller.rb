class Admin::OpencallsubmissionsController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  skip_load_and_authorize_resource
  load_and_authorize_resource
  
  def destroy
    @submission = Opencallsubmission.find(params[:id])
    opencall = @submission.opencall_id
    if can? :destroy, @submission
      if @submission.destroy
        flash[:notice] = 'The submission has been deleted.'
      else
        flash[:error] = 'There was an error deleting this: ' + @submission.errors.inspect
      end
    else
      flash[:error] = "You do not have permission for this"
    end
    redirect_to admin_opencall_opencallsubmissions_path(opencall_id: opencall)
  end

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
