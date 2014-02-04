class Admin::SearchController < ApplicationController
  layout 'admin'
  
  def create
    @hits = []
    @hits += Post.with_translations.advanced_search(params[:searchterm])
    @hits += Page.with_translations.advanced_search(params[:searchterm])
    @hits += Event.with_translations.advanced_search(params[:searchterm])
    @hits += Project.with_translations.advanced_search(params[:searchterm])
  end
  
end