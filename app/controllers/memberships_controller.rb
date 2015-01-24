class MembershipsController < ApplicationController
  
  def index
    years = Membership.pluck(:year).sort
    @members = Membership.joins(:user).where(year: years.last)
    set_meta_tags title: t(:members)
  end
  
end