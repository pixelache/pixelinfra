class HomeController < ApplicationController

  def activities
    
  end
  
  def index
    unless @site.name == 'olsof'
      authenticate_or_request_with_http_basic('Pixelache eyes only! (for now)') do |username, password|
        username == 'trouble' && password == 'desire'
      end
    end
    @users = User.all
    if @site.name == 'pixelache'
      @events = Event.by_subsite(@site.id).published.order("start_at DESC").limit(6)
      @stream = Feed.by_subsite(@site.id).created.order('fed_at DESC').page(params[:page]).per(7)

      @frontitems = Frontitem.by_site(@site.id).order(:position)
      @archive = Archivalimage.random(1).first
    elsif @site.name == 'olsof'
      @feed = Feed.by_subsite(@site.id).created.order('fed_at DESC').page(params[:page]).per(6)
      
    end
  end
  
end
