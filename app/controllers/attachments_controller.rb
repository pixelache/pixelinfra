class AttachmentsController < ApplicationController
  
  def index
    if params[:festival_id]
      @festival = Festival.find(params[:festival_id])
      @attachments = @festival.attachments.public_files
      set_meta_tags title: @festival.name + " " + t(:documents)
    elsif params[:project_id]
      @project = Project.find(params[:project_id])
      @attachments = @project.attachments.public_files
      set_meta_tags title: @project.name + " " + t(:documents)
    end
  end
  
end
