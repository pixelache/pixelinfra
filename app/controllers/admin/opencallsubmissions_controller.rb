class Admin::OpencallsubmissionsController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  
  def index
    @opencall = Opencall.friendly.find(params[:opencall_id])
    @submissions = @opencall.opencallsubmissions
  end
  
  def show
    @opencall = Opencall.friendly.find(params[:opencall_id])
    @submission = Opencallsubmission.find(params[:id])
    
  end
end
