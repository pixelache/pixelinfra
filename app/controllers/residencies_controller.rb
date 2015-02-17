class ResidenciesController < ApplicationController
  
  def index
    @page = @site.pages.published.find('residencies')
    @microresidencies = Residency.micro.order('end_at DESC')
    @production = Residency.production.order('end_at DESC')
    
    set_meta_tags :title => t(:residencies)
  end
  
  
  def show
    @residency = Residency.find(params[:id])
    @microresidencies = Residency.micro.order('end_at DESC')
    @production = Residency.production.order('end_at DESC')
    
    set_meta_tags :title => t(:residencies) + " - " + @residency.name
  end
  
end