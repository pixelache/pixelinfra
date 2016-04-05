class OpencallsubmissionsController < ApplicationController
  
  def create
    @opencall = Opencall.friendly.find(params[:opencall_id])
    @opencallsubmission = Opencallsubmission.new(opencallsubmission_params)
    if @opencallsubmission.save
      flash[:notice] = 'Submission received!'
      render template: 'opencalls/kiitos'
    end
  end
  
  protected
  
  def opencallsubmission_params
    params.require(:opencallsubmission).permit([:name, :opencall_id, :email, :phone, :address, :city, :postcode,
      :country, :website, opencallanswers_attributes: [:id, :answer, :attachment, :opencallquestion_id]])
  end
  
end