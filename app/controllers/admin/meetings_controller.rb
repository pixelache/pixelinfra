class Admin::MeetingsController < Admin::BaseController
  
  def create
    create! { admin_meetings_path }
  end
  
  def update
    update! { admin_meetings_path }
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
  
  def permitted_params
    params.permit(:meeting => [:start_at, :end_at, :meetingtype_id, translations_attributes: [:id, :locale, :name],
     attachments_attributes: [:id, :attachedfile, :title, :description, :item_type, :item_id, :documenttype_id,  :_destroy]
   ])
  end
  
end