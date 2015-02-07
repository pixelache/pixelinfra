class PublicationsController < ApplicationController
  
  def index
    @interviews = Post.by_site(@site).map(&:attachments).flatten.compact
    @videos = Event.by_site(@site).map(&:videos).flatten.compact
  end
  
end