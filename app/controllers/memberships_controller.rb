class MembershipsController < ApplicationController
  
  def contact
    @member = User.find(params[:id])

    @contact_form = ContactForm.new(params[:contact_form])
  
    if verify_recaptcha(:model => @contact_form)
      @contact_form.recipient = @member.email
      if @contact_form.deliver
        flash[:notice] = t(:your_message_was_delivered)
        redirect_to "/member/#{@member.slug}"
      else
        flash[:error] = t(:error_sending_message) + @contact_form.errors.full_messages.join(" ; ")
        set_meta_tags title: @member.name
        @memberships = @member.memberships.sort_by(&:year).reverse
        @current_year = Membership.pluck(:year).uniq.sort.last
        render template: "memberships/show"
      end
    else
      flash[:error] = 'There was an errror with your captcha'
      @memberships = @member.memberships.sort_by(&:year).reverse
      @current_year = Membership.pluck(:year).uniq.sort.last
      set_meta_tags title: @member.name
      render template: "memberships/show"
    end
  end
  
  
  def feed
    if params[:member_id]
      @member = User.find(params[:member_id])
      @feed = Feedcache.where(user_id: @member.id).order(issued_at: :desc).page(params[:page]).per(30)
      set_meta_tags title: t(:member_activity) + " : #{@member.name}"
    else
      @feed = Feedcache.order(issued_at: :desc).page(params[:page]).per(30)
      set_meta_tags title: t(:member_activity)
    end
    
  end
  
  def index
    years = Membership.pluck(:year).sort
    @members = Membership.joins(:user).where(year: years.last)
    @past_members = Membership.all.to_a.uniq(&:user).delete_if{|x| @members.map(&:user).include? x.user }
    set_meta_tags title: t(:members)
  end
  
  def show
    @member = User.find(params[:id])
    @memberships = @member.memberships.sort_by(&:year).reverse
    @current_year = Membership.pluck(:year).uniq.sort.last
    @contact_form = ContactForm.new
    if @memberships.empty?
      flash[:error] = t(:this_user_is_not_a_member)
      redirect_to '/members'
    end

    set_meta_tags title: @member.name
  end
  
end