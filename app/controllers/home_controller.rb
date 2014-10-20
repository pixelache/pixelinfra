class HomeController < ApplicationController

  def activities
    
  end
  
  def index
    authenticate_or_request_with_http_basic('Pixelache eyes only! (for now)') do |username, password|
      username == 'trouble' && password == 'desire'
    end
    @users = User.all
    if @site.name == 'pixelache'
      @posts = Post.by_subsite(@site.id).published.order('published_at desc').limit(3)
      @events = Event.by_subsite(@site.id).published.order("start_at DESC").limit(6)
      @stream = @posts + @events
      @stream = @stream.flatten.sort_by{|x| x.stream_date }.reverse
      @frontitems = Frontitem.by_site(@site.id).order(:position)
      @archive = Archivalimage.random(1).first
    elsif @site.name == 'olsof'
      @feed = Feed.by_subsite(@site.id).created.order('fed_at DESC').page(params[:page]).per(6)
      
    end
  end
  
end
