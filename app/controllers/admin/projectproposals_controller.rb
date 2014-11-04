class Admin::ProjectproposalsController < Admin::BaseController

  protected
  
  def permitted_params
    params.permit(:projectproposal => [:name, :project_id, :description, :long_description, :primary_initiator_id, :cosupporters, :producer, :treasurer, :documentation, :communication, :additional_experts, :reporting, :imagined_participants, :equipment, :budget, :external_funding, :inkind, :people_expertise, :where, :when, :when_will_it_end, :slug, :why])
  end

end