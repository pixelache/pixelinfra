class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    @users = User.all
  end

  def edit
    @user = User.friendly.find(params[:id])
    if @user != current_user
      unless can? :manage, @user
        flash[:error] = 'You cannot edit another user.'
        redirect_to '/'
      end
    end
    set_meta_tags title: t(:edit_your_profile)
  end
  
  def update
    @user = User.find(params[:id])
    if current_user == @user || current_user.has_role?(:goddess)
      if @user.update_attributes(permitted_params)
        flash[:notice] = 'Profile updated'
        redirect_to '/'
      else
        render :edit
      end
    end
  end


  def show
    @user = User.friendly.find(params[:id])
  end
  
  protected
  
  def permitted_params
    params.require(:user).permit(:avatar, :username, :bio, :feed_urls, :twitter_name, :website, authentications_attributes: [:id, :provider, :username ] )
  end

end
