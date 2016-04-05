class Admin::OpencallsubmissionsController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  
  def index
    @opencall = Opencall.friendly.find(params[:id])
    @submissions = @opencall.opencallsubmissions
  end
  
  def show
    @opencall = Opencall.friendly.find(params[:id])
    @submission = Opencallsubmission.find(params[:id])
    
  end
end
