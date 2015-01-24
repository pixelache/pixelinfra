class SearchController < ApplicationController
  
  def create
    @hits = []
    @term = params[:search][:term]
    @hits += Event.with_translations.advanced_search({event_translations: {name: @term}, event_translations: {description: @term}}, false)
    @hits += Post.published.with_translations.advanced_search({post_translations: {title: @term}, post_translations: {body: @term}}, false)
    @hits += Project.with_translations.advanced_search({name: @term, project_translations: {description: @term}}, false)
    @hits += Residency.with_translations.advanced_search(residency_translations: {description: @term })
    @hits += Page.published.with_translations.advanced_search( { :page_translations => { name: @term}, :page_translations => {body: @term}}, false )
    @hits.flatten!
    @hits.uniq!
    set_meta_tags title: t(:search_results_for, result: @term)
  end
  
end