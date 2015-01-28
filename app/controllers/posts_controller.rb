class PostsController < ApplicationController

  
  def index
    if params[:festival_id]
      @festival = Festival.find(params[:festival_id])
      @posts = Post.by_site(@site).by_festival(@festival).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: @festival.name + " " + t(:posts)
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @posts = Post.by_site(@site).by_user(@user.id).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: t(:all_posts_by, member: @user.name)
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
      flash[:notice] = 'This post is not published.'
      if current_user
        if !can? :read, @post
          redirect_to posts_path
        end
      else
        redirect_to posts_path
      end
    end
    if request.xhr?
      render template: 'posts/ajax_post', layout: false
    end
  end
  
  
end