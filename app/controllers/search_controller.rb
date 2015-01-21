class SearchController < ApplicationController
  
  def create
    render :text => params[:search][:term]
  end
  
end