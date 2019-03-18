class Admin::PostsController < ApplicationController

  layout 'admin'
  authorize_resource
  before_action :authenticate_user!

  
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
  
  def attendees
    @post = Post.friendly.find(params[:id])
    @attendees = @post.attendees.order(:created_at)

  end
  
  def check_permissions
    authorize! :create, resource
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post created.'
      redirect_to admin_posts_path
    else
      flash[:error] = 'Error saving post.'
    end
  end

  def destroy
    @post = Subsite.find(params[:subsite_id]).posts.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  def edit
    @post = Subsite.find(params[:subsite_id]).posts.find(params[:id])
    unless @post.feeds.empty?
      @post.add_to_newsfeed = true
    end
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
    @post = Post.new
    set_meta_tags :title => t(:new_post)
    
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
    if @post.update_attributes(post_params)
      redirect_to  admin_posts_path 
    end
  end
  
  protected
  
  def post_params
    params.require(:post).permit(:published, :slug, :subsite_id, :creator_id, 
      :last_modified_id, :external,  :wordpress_id, :published_at, :image, :image_width, :image_height,
       :image_content_type, :image_size, :event_name, :event_id,  :project_name, :residency_id, :project_id, 
       :registration_required, :email_registrations_to, :question_description,
       :question_creators, :question_motivation, :email_template, :max_attendees,
       :festival_name, :festival_id, :add_to_newsfeed, :tag_list, post_category_ids: [], 
        translations_attributes: [:id, :locale, :title, :body, :excerpt],
         photos_attributes: [:id, :filename, :title, :credit, :_destroy],
         festivaltheme_ids: [], 
          attachments_attributes: [:id, :documenttype_id, :attachedfile, 
            :_destroy, :year_of_publication,  :title, :description, :public, :_destroy])
  end
  
end