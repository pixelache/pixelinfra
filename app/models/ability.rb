class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :goddess
      can :manage, :all
      
    elsif user.has_role? :member
      can :manage, Event
      can :manage, Page, :subsite => {:name => 'pixelache' }
      can :manage, Post, :subsite => {:name => 'pixelache' }
      can :manage, Festival, :subsite => {:name => 'pixelache' }
      can :manage, Project
      can :create, Projectproposal
      can :read, Projectproposal
      can :manage, Projectproposal, :primary_initiator_id => current_user.id
      
    elsif user.has_role? :olsof_staff
      can :manage, Event, :subsite => {:name => 'olsof' }
      can :manage, Page, :subsite => {:name => 'olsof' }
      can :manage, Post, :subsite => {:name => 'olsof' }
      can :read, Subsite, :name => 'olsof'
      can :create, Event
      can :manage, Node
      can :create, Page
      can :create, Post
      can :manage, Place
      can :manage, Festival
      can :manage, Project
      cannot :manage, Step
    end
    
    
        # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
