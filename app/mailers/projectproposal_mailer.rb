class ProjectproposalMailer < ActionMailer::Base
  default from: "no-reply@pixelache.ac"
  
  def new_proposal(proposal)
    @projectproposal = proposal
    mail(to: 'members@pixelache.ac',  subject: "New project proposal: #{@projectproposal.name}") 
  end


end
