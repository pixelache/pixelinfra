class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      unless can? :manage, @user
        flash[:error] = 'You cannot edit another user.'
        redirect_to '/'
      end
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end


  def show
    @user = User.find(params[:id])
  end
  
  protected
  
  def permitted_params
    params.require(:user).permit(authentications_attributes: [:id, :provider, :username ] )
  end

end
