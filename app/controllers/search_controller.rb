class SearchController < ApplicationController
  
  def create
    @hits = []
    @term = params[:search][:term]
    @hits += Event.basic_search(@term)
    @hits += Post.basic_search(@term)
    @hits += Project.basic_search(@term)
    @hits += Residency.basic_search(@term)
    @hits += Page.basic_search(@term)
    @hits.flatten!
    set_meta_tags title: t(:search_results_for, result: @term)
  end
  
end