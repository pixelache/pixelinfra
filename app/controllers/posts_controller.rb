class PostsController < InheritedResources::Base
  
  actions :index, :show
  
  def index
    if params[:festival_id]
      @festival = Festival.find(params[:festival_id])
      @posts = Post.by_site(@site).by_festival(@festival).published.order('published_at DESC').page(params[:page]).per(12)
    else
      @posts = Post.by_site(@site).published.order('published_at DESC').page(params[:page]).per(12)
    end
  end
  
  def show
    @post = @site.posts.friendly.find(params[:id])
    set_meta_tags :title => @post.title
    if @post.festival
      @festival = @post.festival
    end
    if !@post.published
      if current_user
        if can? :read, @post
          flash[:notice] = 'This post is not published.'
          super
        end
      end
    else
      super
    end
  end
  
end