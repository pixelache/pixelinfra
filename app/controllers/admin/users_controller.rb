class Admin::UsersController < Admin::BaseController

  def create
    create! { admin_users_path }
  end
  
  def update
    update! { admin_users_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:user => [:avatar, role_ids: []  ])
  end
end