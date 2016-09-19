class Admin::MeetingtypesController < Admin::BaseController
  
  def index
    @meetingtypes = Meetingtype.all
  end
  
  def create
    @meetingtype = Meetingtype.new(meetingtype_params)
    if @meetingtype.save
      flash[:notice] = 'Saved meeting type.'
      redirect_to admin_meetingtypes_path
    else
      flash[:error] = 'Error saving meeting'
      render template: 'admin/meetingtypes/new'
    end
  end
  
  def edit
    @meetingtype = Meetingtype.find(params[:id])
  end
  
  def destroy
    @meetingtype = Meetingtype.find(params[:id])
    if @meetingtype.destroy
      flash[:notice] = 'Meeting type deleted'
      redirect_to admin_meetingtypes_path
    end
  end
  
  def new
    @meetingtype = Meetingtype.new
  end
  
  def update
    @meetingtype = Meetingtype.find(params[:Oid])
    if @meetingtype.update_attributes(meetingtype_params)
      flash[:notice] = 'Updated meeting type.'
      redirect_to admin_meetingtypes_path
    else
      flash[:error] = 'Error saving meeting'
      render template: 'admin/meetingtypes/new'
    end
  end
  
  private
  
  def meetingtype_params
    params.require(:meetingtype).permit(translations_attributes: [:id, :locale, :name])
  end
    
end