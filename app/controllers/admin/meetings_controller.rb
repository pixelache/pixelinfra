class Admin::MeetingsController < Admin::BaseController
  skip_load_and_authorize_resource
  load_and_authorize_resource
  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      flash[:notice] = 'Meeting created.'
      redirect_to admin_meetings_path
    else
      flash[:error] = 'Error updating document type: ' + @meeting.errors.inspect
    end
  end
  
  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      flash[:notice] = 'Meeting updated.'
      redirect_to admin_documenttypes_path
    else
      flash[:error] = 'Error updating meeting: ' + @meeting.errors.inspect
    end
  end
  
  def index
    @meetings = Meeting.order(start_at: :desc).page(params[:page]).per(40)
  end
  
  def edit
    @meeting = Meeting.find(params[:id])
    set_meta_tags :title => t(:edit_meeting)
  end
  
  def new
    @meeting = Meeting.new
    set_meta_tags :title => t(:new_meeting)
  end
  
  protected
  
  def meeting_params
    params.require(:meeting).permit(:start_at, :end_at, :meetingtype_id, translations_attributes: [:id, :locale, :name],
     attachments_attributes: [:id, :attachedfile, :title, :description, :item_type, :item_id, :documenttype_id,  :_destroy]
   )
  end
  
end