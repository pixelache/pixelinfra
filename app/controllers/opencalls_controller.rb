class OpencallsController < ApplicationController
  
  def show
    @opencall = Opencall.friendly.find(params[:id])
    if @opencall.page
      redirect_to @opencall.page
    else
      @opencallsubmission = Opencallsubmission.new(opencall: @opencall)
      @opencall.opencallquestions.sort_by(&:created_at).each do |qs|
        @opencallsubmission.opencallanswers.build(opencallquestion: qs)
      end
    end
  end
  
end
