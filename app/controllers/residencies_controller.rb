class ResidenciesController < ApplicationController
  
  def index
    @page = @site.pages.published.find('residencies')
    @microresidencies = Residency.micro
    @production = Residency.production
    
    set_meta_tags :title => t(:residencies)
  end
  
  
  def show
    @residency = Residency.find(params[:id])
    @microresidencies = Residency.micro
    @production = Residency.production
    
    set_meta_tags :title => t(:residencies) + " - " + @residency.name
  end
  
end