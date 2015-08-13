class PostsController < ApplicationController

  
  def index
    if params[:festival_id]
      @festival = Festival.find(params[:festival_id])
      @posts = Post.by_site(@site).by_festival(@festival).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: @festival.name + " " + t(:posts)
      
    elsif params[:archive_id]
      @year = params[:archive_id]
      @posts = Post.by_site(@site).by_year(@year).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: t(:news) + " #{@year}"
      
    elsif params[:project_id]
      @project = Project.find(params[:project_id])
      @posts = Kaminari.paginate_array(@project.self_and_descendants.visible.map{|x| x.posts.by_site(@site).published }.flatten.sort_by(&:published_at).reverse).page(params[:page]).per(12)
      set_meta_tags title: @project.name + " " + t(:posts)    

    elsif params[:residency_id]
      @residency = Residency.find(params[:residency_id])
      posts = @residency.posts.published
      posts += @residency.project.posts.published if @residency.project
      @posts = Kaminari.paginate_array(posts.flatten.uniq.sort_by{|x| x.published_at}.reverse).page(params[:page]).per(12)
      set_meta_tags title: @residency.name + " " + t(:posts) 
      
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @posts = Post.by_site(@site).by_user(@user.id).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: t(:all_posts_by, member: @user.name)
    else
      @posts = Post.by_site(@site).published.order('published_at DESC').page(params[:page]).per(12)
      if @posts.empty?
        if @site.festival
          @posts = Post.by_festival(@site.festival).published.order(published_at: :desc).page(params[:page]).per(12)
        end
      end
      set_meta_tags title: t(:news)

    end
  end
  
  def show

    begin
      @post = @site.posts.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound

      @post = Post.find(params[:id])
      if @post
        if @post.festival
          @festival = @post.festival
          if @festival.subsite
            if !request.host.split(/\./).include?(@festival.subsite.subdomain)
              redirect_to subdomain: @festival.subsite.subdomain
            end
          end
        elsif @post.subsite != @site
          redirect_to "http://#{@post.subsite.subdomain}/posts/#{params[:id]}"
        end
      end
    end
    
    set_meta_tags :title => @post.title
    if @post.festival
      @festival = @post.festival
 
      if @festival.subsite
        if !request.host.split(/\./).include?(@festival.subsite.subdomain)
          redirect_to subdomain: @festival.subsite.subdomain
        end

      end
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