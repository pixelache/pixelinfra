class Admin::CommentsController < Admin::BaseController
  
  def create
    if params[:projectproposal_id]
      @master = Projectproposal.find(params[:projectproposal_id])
    end
    if params[:opencallsubmission_id]
      @master = Opencallsubmission.find(params[:opencallsubmission_id])
    end
    @master.comments << Comment.new(permitted_params[:comment])
    if @master.save!
      flash[:notice] = t(:your_comment_was_added)
    else
      flash[:error] = t(:your_comment_was_not_added)
    end
    redirect_to [:admin, @master]
  end
  
  protected
  
  def permitted_params
    params.permit(:projectproposal_id, :comment => [:item_type, :item_id, :user_id, :content, :attachment, :image])
  end
  
end