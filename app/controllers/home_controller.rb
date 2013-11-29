class HomeController < ApplicationController

  def index
    @users = User.all
    @home_text = @site.pages.find('home')
  end
  
end
