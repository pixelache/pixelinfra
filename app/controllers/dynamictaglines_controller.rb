class DynamictaglinesController < ApplicationController
  def index
    @dynamictagline = Dynamictagline.find_by(:subsite_id => @site.id).tagline rescue "Festival of Electronic Art and Subcultures"
    unless request.xhr?
      redirect_to '/'
    end
  end
end
