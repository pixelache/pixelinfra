class Admin::CommentsController < Admin::BaseController
  
  def create
    if params[:projectproposal_id]
      @master = Projectproposal.find(params[:projectproposal_id])
    end
    if params[:opencallsubmission_id]
      @master = Opencallsubmission.find(params[:opencallsubmission_id])
    end
    comment = Comment.new(comment_params)
    comment.user = current_user
    @master.comments << comment
    if @master.save!
      flash[:notice] = t(:your_comment_was_added)
    else
      flash[:error] = t(:your_comment_was_not_added)
    end
    redirect_to [:admin, @master]
  end
  
  protected
  
  def comment_params
    params.require(:comment).permit(:item_type, :item_id, :user_id, :content, :attachment, :image)
  end
  
end