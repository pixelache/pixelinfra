class Admin::ProjectproposalsController < Admin::BaseController
  handles_sortable_columns
  
  
  def create
    @projectproposal = Projectproposal.new(projectproposal_params)
    @projectproposal.primary_initiator = current_user
    if @projectproposal.save
      flash[:notice] = 'Project proposal saved.'
      redirect_to admin_projectproposals_path
    else
      flash[:error] = 'Error saving proposal: ' + @projectproposal.errors.inspect
    end
  end
  
  def show
    @projectproposal = Projectproposal.friendly.find(params[:id])
    set_meta_tags :title => @projectproposal.name
  end
  
  def edit
    @projectproposal = Projectproposal.friendly.find(params[:id])
    set_meta_tags :title => 'Edit: ' + @projectproposal.name
  end
  
  def update
    @projectproposal = Projectproposal.friendly.find(params[:id])
    if @projectproposal.update_attributes(projectproposal_params)
      flash[:notice] = 'Proposal updated.'
      redirect_to admin_projectproposals_path
    else
      flash[:error] = 'Error updating page: ' + @projectproposal.errors.inspect
    end
  end
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "id"
        "id #{direction}"
      when "user"
        "LOWER(users.name) #{direction}"
      when "comments"
        "comment_count #{direction}"
      when "name"
        "LOWER(name) #{direction}"
      else
        "updated_at DESC"
      end
    end
    set_meta_tags :title => t(:project_proposals)
    @current = Projectproposal.current.joins(:primary_initiator).includes(:comments).order(order)
    @archived = Projectproposal.archived.joins(:primary_initiator).includes(:comments).order(order)
  end
  
  
  def new
    @projectproposal = Projectproposal.new
    @projectproposal.primary_initiator = current_user
    set_meta_tags :title => t(:new_project_proposal)
    
  end
  
  protected
  
  def projectproposal_params
    params.require(:projectproposal).permit(:name, :project_id, :archived, :festival_id, :event_id, :description, :long_description, :primary_initiator_id, :cosupporters, :producer, :treasurer, :documentation, :communication, :additional_experts, :reporting, :imagined_participants, :equipment, :offspring_id, :budget, :external_funding, :inkind, :people_expertise, :where, :when, :when_will_it_end, :slug, :why)
  end

end