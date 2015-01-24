class MembershipsController < ApplicationController
  
  def index
    years = Membership.pluck(:year).sort
    @members = Membership.joins(:user).where(year: years.last)
    @past_members = Membership.all.to_a.uniq(&:user).delete_if{|x| @members.map(&:user).include? x.user }
    set_meta_tags title: t(:members)
  end
  
end