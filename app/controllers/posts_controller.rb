class PostsController < ApplicationController

  
  def index
    if params[:festival_id]
      @festival = Festival.friendly.find(params[:festival_id])
      @posts = Post.by_festival(@festival).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: @festival.name + " " + t(:posts)
      
    elsif params[:archive_id]
      @year = params[:archive_id]
      @posts = Post.by_site(@site).by_year(@year).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: t(:news) + " #{@year}"
      
    elsif params[:project_id]
      @project = Project.friendly.find(params[:project_id])
      @posts = Kaminari.paginate_array(@project.self_and_descendants.visible.map{|x| x.posts.by_site(@site).published }.flatten.sort_by(&:published_at).reverse).page(params[:page]).per(12)

      set_meta_tags title: @project.name + " " + t(:posts)    

    elsif params[:residency_id]
      @residency = Residency.friendly.find(params[:residency_id])
      posts = @residency.posts.published
      posts += @residency.project.posts.published if @residency.project
      @posts = Kaminari.paginate_array(posts.flatten.uniq.sort_by{|x| x.published_at}.reverse).page(params[:page]).per(12)
      set_meta_tags title: @residency.name + " " + t(:posts) 
      
    elsif params[:user_id]
      @user = User.friendly.find(params[:user_id])
      @posts = Post.by_site(@site).by_user(@user.id).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: t(:all_posts_by, member: @user.name)
    else
      @posts = Post.by_site(@site).published.order('published_at DESC').page(params[:page]).per(12)

      if @posts.empty?
        if @site.festival
          @posts = Post.by_festival(@site.festival).published.order(published_at: :desc).page(params[:page]).per(12)
        end
      end
      set_meta_tags title: t(:news),
        canonical: posts_url,
        og: {image:'https://pixelache.ac/assets/pixelache/images/PA_logo.png', 
              title: t(:news), type: 'website', url: posts_path
            }, 
        twitter: {card: 'summary', site: '@pixelache'},
        alternate: {"en" => posts_url(locale: :en), "fi" => posts_url(locale: :fi)}
    end
  end
  
  def show

    begin
      @post = @site.posts.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound

      @post = Post.friendly.find(params[:id])
      if @post
        if @post.festival
          @festival = @post.festival
          if @festival.subsite
            if !request.host.split(/\./).include?(@festival.subsite.subdomain)
              redirect_to subdomain: @festival.subsite.subdomain unless request.xhr?
            end
          end
        elsif @post.subsite != @site
          redirect_to "https://#{@post.subsite.subdomain}/posts/#{params[:id]}" unless request.xhr?
        end
      end
    end
    if request.xhr?

      render template: 'posts/ajax_post', layout: false
    else
      # build translation alternates in URL
      if @post.body(:en) != @post.body(:fi)
        a = Hash.new
        a["en"] = url_for(@post) + "?locale=en"
        a["fi"] = url_for(@post) + "?locale=fi"
      else
        a = {}
      end

      
      set_meta_tags :title => @post.title, 
                    canonical: url_for(@post),
                    og: {image: (@post.image? ?  [ @post.image.url(:box), { secure_url: @post.image.url(:box) } ] : 'https://pixelache.ac/assets/pixelache/images/PA_logo.png'), 
                          title: @post.title, type: 'website', url: url_for(@post),
                          description: ActionView::Base.full_sanitizer.sanitize(@post.description[0..500]) + "..."
                        }, 
                    twitter: {card: 'summary', site: '@pixelache'},
                    alternate: a
        
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
    end
  end
  
  
end