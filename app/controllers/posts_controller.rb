class PostsController < InheritedResources::Base
  
  actions :index, :show
  
  def show
    @post = @site.posts.published.find(params[:id])
  end
  
end