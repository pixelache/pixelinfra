class FestivalsController < InheritedResources::Base
  actions :show, :index, :page
  
  def index
    if @site.name == 'pixelache'
      @festivals = Festival.all.by_node(1).order(:end_at).reverse
    else
      @festivals = Festival.all
    end
  end
  
  def page
    
    @festival = Festival.find(params[:id])
    if params[:page] =~ /\//
      p = params[:page].split(/\//).last
    else
      p = params[:page]
    end
    potential = p =~ /^\d+$/ ? Page.find(p) : Page.where(:slug => p)
    
    @page = @festival.pages.map(&:self_and_descendants).flatten.delete_if{|x| !potential.include?(x) }.first
    set_meta_tags :title => [@festival.name, @page.name].join(" - ")
  end
  
  def show
    @festival = Festival.find(params[:id])
    set_meta_tags :title => @festival.name
  end
end
