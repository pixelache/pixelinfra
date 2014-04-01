class DynamictaglinesController < ApplicationController
  
  def index
    @dynamictagline = Dynamictagline.find_by(:subsite_id => @site.id).tagline rescue "Festival of Electronic Art and Subcultures"
    render :text => @dynamictagline
  end
  
end