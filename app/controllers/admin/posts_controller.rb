class Admin::PostsController < ApplicationController
  inherit_resources
  layout 'admin'
  authorize_resource
  before_filter :authenticate_user!
  
  has_scope :page, :default => 1
  has_scope :by_festival
  has_scope :by_project
  has_scope :by_subsite
  has_scope :published
  has_scope :by_tag
  has_scope :is_pixelache, type: :boolean, default: true
  has_scope :is_external, type: :boolean
  has_scope :by_year
  handles_sortable_columns
  autocomplete :event, :name, :extra_data => [:start_at], :display_value => :event_with_date
  autocomplete :project, :name
  autocomplete :festival, :name, :extra_data => [:name], :display_value => :name

  def check_permissions
    authorize! :create, resource
  end
  
  def create
    create! { admin_posts_path }
  end
  
  
  def destroy
    @post = Subsite.find(params[:subsite_id]).posts.find(params[:id])
    destroy! { admin_posts_path }
  end
  
  def edit
    @post = Subsite.find(params[:subsite_id]).posts.find(params[:id])
  end
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "id"
        "id #{direction}"
      when "title"
        "LOWER(slug) #{direction}"
      when "published"
        "published #{direction}, published_at #{direction}"
      when "site"
        "subsites.name #{direction}"
      else
        "published_at DESC"
      end
    end
    @posts = apply_scopes(Post).includes(:subsite).order(order).page(params[:page]).per(30)
  end
  
  def options
    @posts = Post.includes(:subsite).published.order('published_at DESC').page(params[:page]).per(70)  
    render :layout => false
  end
  
  def update
    @post = Subsite.find(params[:post][:subsite_id]).posts.find(params[:id])
    update! { admin_posts_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:post => [:published, :slug, :subsite_id, :creator_id, :last_modified_id, :external,  :wordpress_id, :published_at, :image, :image_width, :image_height, :image_content_type, :image_size, :event_name, :event_id,  :project_name, :project_id, :festival_name, :festival_id, :hide_from_feed, :tag_list, post_category_ids: [],  translations_attributes: [:id, :locale, :title, :body, :excerpt], photos_attributes: [:id, :filename]])
  end
  
end