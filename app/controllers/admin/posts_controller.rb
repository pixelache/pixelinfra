class Admin::PostsController < Admin::BaseController
  
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
  
  def update
    @post = Subsite.find(params[:post][:subsite_id]).posts.find(params[:id])
    update! { admin_posts_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:post => [:published, :slug, :subsite_id, :creator_id, :last_modified_id, :wordpress_id, :published_at, :image, :image_width, :image_height, :image_content_type, :image_size, translations_attributes: [:id, :locale, :title, :body, :excerpt]])
  end
  
end