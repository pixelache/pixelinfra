class PostsController < InheritedResources::Base
  
  actions :index, :show
  
  def show
    @post = @site.posts.friendly.find(params[:id])
    set_meta_tags :title => @post.title
    
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