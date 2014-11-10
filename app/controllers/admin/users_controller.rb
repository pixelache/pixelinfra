class Admin::UsersController < Admin::BaseController
  handles_sortable_columns
  has_scope
  
  def create
    create! { admin_users_path }
  end
  
  def update
    update! { admin_users_path }
  end
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "LOWER(name) #{direction}"
      when "email"
        "email #{direction}"
      when "registered"
        "created_at #{direction}"
      else
        "created_at DESC"
      end
    end
    @users = apply_scopes(User).includes(:roles).order(order).page(params[:page]).per(30)
    set_meta_tags :title => 'Users'
  end
  
  protected
  
  def permitted_params
    params.permit(:user => [:avatar, :name, :username, :email, role_ids: [], authentications_attributes: [:id, :user_id, :provider, :uid, :username]  ])
  end
end