class StepsController < ApplicationController
  
  def index
    @steps = Step.all
  end
  
  def show
    @step = Step.friendly.find(params[:id])
  end
  
end