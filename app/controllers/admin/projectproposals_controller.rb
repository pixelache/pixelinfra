class Admin::ProjectproposalsController < Admin::BaseController
  handles_sortable_columns
  
  def show
    @projectproposal = Projectproposal.find(params[:id])
    set_meta_tags :title => @projectproposal.name
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
        "created_at DESC"
      end
    end
    set_meta_tags :title => t(:project_proposals)
    @projectproposals = Projectproposal.joins(:primary_initiator).includes(:comments).order(order)
  end
  
  
  def new
    set_meta_tags :title => t(:new_project_proposal)
    super
  end
  
  protected
  
  def permitted_params
    params.permit(:projectproposal => [:name, :project_id, :description, :long_description, :primary_initiator_id, :cosupporters, :producer, :treasurer, :documentation, :communication, :additional_experts, :reporting, :imagined_participants, :equipment, :offspring_id, :budget, :external_funding, :inkind, :people_expertise, :where, :when, :when_will_it_end, :slug, :why])
  end

end