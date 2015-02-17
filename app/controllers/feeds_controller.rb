class FeedsController < ApplicationController

  def index
    @feed = Feed.by_subsite(@site.id).created.order('fed_at DESC').page(params[:page]).per(25)
    respond_to do |format|
      #format.html
      format.rss
    end
    
  end
  
end