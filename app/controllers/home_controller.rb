class HomeController < ApplicationController

  def index
    @users = User.all
    if @site.name == 'pixelache'
      @posts = Post.by_subsite(@site.id).published.order('published_at desc').limit(3)
      @events = Event.by_subsite(@site.id).published.order("start_at DESC").limit(6)
    else
      @home_text = @site.pages.find('home')
    end
  end
  
end
