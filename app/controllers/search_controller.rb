class SearchController < ApplicationController
  
  def create
 
    @hits = []
    @term = params[:search][:term]
    @hits += Event.by_site(@site).with_translations.advanced_search({event_translations: {name: @term}, event_translations: {description: @term}}, false)
    @hits += Post.by_site(@site).published.with_translations.advanced_search({post_translations: {title: @term}, post_translations: {body: @term}}, false)
    if @site.id == 1
      @hits += Project.with_translations.advanced_search({name: @term, project_translations: {description: @term}}, false)
      @hits += Residency.with_translations.advanced_search(residency_translations: {description: @term })
    end
    @hits += Page.by_site(@site).published.with_translations.advanced_search( { :page_translations => { name: @term}, :page_translations => {body: @term}}, false )
    @hits.flatten!
    @hits.uniq!
    @hits = @hits.group_by{|x| x.class.to_s }
    set_meta_tags title: t(:search_results_for, results: @term)
  end
  
end