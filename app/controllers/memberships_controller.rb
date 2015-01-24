class MembershipsController < ApplicationController
  
  def index
    years = Membership.pluck(:year).sort
    @members = Membership.joins(:user).where(year: years.last)
    @past_members = Membership.all.to_a.uniq(&:user).delete_if{|x| @members.map(&:user).include? x.user }
    set_meta_tags title: t(:members)
  end
  
  def show
    @member = User.find(params[:id])
    if @member.memberships.empty?
      flash[:error] = t(:this_user_is_not_a_member)
      redirect_to '/members'
    end
    set_meta_tags title: @member.name
  end
  
end