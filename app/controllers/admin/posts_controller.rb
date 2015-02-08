class Admin::PostsController < ApplicationController
  inherit_resources
  layout 'admin'
  authorize_resource
  before_filter :authenticate_user!
  skip_before_filter :require_no_authentication
  
  has_scope :page, :default => 1
  has_scope :by_festival
  has_scope :by_project
  has_scope :by_subsite
  has_scope :published
  has_scope :by_tag
  has_scope :is_pixelache, type: :boolean, default: false
  has_scope :is_external, type: :boolean
  has_scope :by_year
  has_scope :by_name
  handles_sortable_columns
  autocomplete :event, :name, :extra_data => [:start_at], :display_value => :event_with_date
  autocomplete :project, :name, :extra_data => [:name], :display_value => :name
  autocomplete :festival, :name, :extra_data => [:name], :display_value => :name
  autocomplete :post, :title, :extra_data => [:title], :display_value => :title
  
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
    set_meta_tags :title => t(:edit_post)
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
    set_meta_tags :title => t(:posts)
    @posts = apply_scopes(Post).includes(:subsite).order(order).page(params[:page]).per(20)
  end
  
  def new
    set_meta_tags :title => t(:new_post)
    super
  end
  
  def options
    @posts = Post.includes(:subsite).published.order('published_at DESC').page(params[:page]).per(70)  
    render :layout => false
  end
  
  def update
    begin
      @post = Subsite.find(params[:post][:subsite_id]).posts.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @post = Post.find(params[:id])
    end
    if @post.update_attributes(permitted_params[:post])
      redirect_to  admin_posts_path 
    end
  end
  
  protected
  
  def permitted_params
    params.permit(:post => [:published, :slug, :subsite_id, :creator_id, :last_modified_id, :external,  :wordpress_id, :published_at, :image, :image_width, :image_height, :image_content_type, :image_size, :event_name, :event_id,  :project_name, :residency_id, :project_id, :festival_name, :festival_id, :hide_from_feed, :tag_list, post_category_ids: [],  translations_attributes: [:id, :locale, :title, :body, :excerpt], photos_attributes: [:id, :filename, :title, :credit], attachments_attributes: [:id, :documenttype_id, :attachedfile, :_destroy, :title, :description]])
  end
  
end