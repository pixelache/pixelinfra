class HomeController < ApplicationController

  def activities
    
  end
  
  def index
    # unless @site.name == 'olsof'
    #   authenticate_or_request_with_http_basic('Pixelache eyes only! (for now)') do |username, password|
    #     username == 'trouble' && password == 'desire'
    #   end
    # end
    @users = User.all
    if @site.name == 'pixelache'
      @events = Event.by_subsite(@site.id).published.order("start_at DESC").limit(24)
      unless @events.map(&:festival).compact.nil?
        @events.map(&:festival).compact.uniq.each do |festival|
          @events.to_a.delete_if{|x| x.start_at.to_date >= festival.start_at.to_date }
          @events += [festival]
        end
      end
      festivals = Festival.published.where(["start_at >= ? ",@events.last.start_at])
      
      @events += festivals
      @events.flatten!
      @events.sort_by!(&:start_at).reverse!.uniq!
      @events = @events.take(5)
      @stream = Feed.by_subsite(@site.id).created.order('fed_at DESC').page(params[:page]).per(7)

      # @frontitems = Frontitem.by_site(@site.id).order(:position)
      @archive = Archivalimage.random(1).first
    elsif @site.name == 'livingspaces' || @site.name == 'empathy'
      @posts = Post.by_festival(@site.festival).published.order(published_at: :desc).limit(4)
    elsif @site.name == 'olsof' 
      @feed = Feed.by_subsite(@site.id).created.order('fed_at DESC').page(params[:page]).per(6)
    elsif  @site.name == 'documenting'  # hopefully change to just "else" soon
      @pages = Page.friendly.find('documenting-media-art').children.page(params[:page]).per(6)
    end
    
    @frontitems = Frontitem.by_site(@site.id).order(:position)
  end
  
end
