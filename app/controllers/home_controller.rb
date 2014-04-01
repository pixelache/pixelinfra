class HomeController < ApplicationController

  def index
    @users = User.all
    if @site.name == 'pixelache'
      authenticate_or_request_with_http_basic('Pixelache eyes only! (for now)') do |username, password|
        username == 'trouble' && password == 'desire'
      end
      @posts = Post.by_subsite(@site.id).published.order('published_at desc').limit(3)
      @events = Event.by_subsite(@site.id).published.order("start_at DESC").limit(6)
      @frontitems = Frontitem.by_site(@site.id).order(:position)
    else
      @home_text = @site.pages.find('home')
    end
  end
  
end
