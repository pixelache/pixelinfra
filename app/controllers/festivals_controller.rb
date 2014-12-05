class FestivalsController < InheritedResources::Base
  actions :show, :index, :page, :attendees
  
  def attendees
    @festival = Festival.find(params[:festival_id])
    set_meta_tags :title => @festival.name + " " + t(:coming_future)
  end
  
  def index
    if @site.name == 'pixelache'
      @festivals = Festival.published.by_node(1).order(:end_at).reverse
    else
      @festivals = Festival.published
    end
  end
  
  def page
    
    @festival = Festival.find(params[:id])
    if params[:page] =~ /\//
      p = params[:page].split(/\//).last
    else
      p = params[:page]
    end
    potential = p =~ /^\d+$/ ? Page.where(:id => p) : Page.where(:slug => p)
    
    @page = @festival.pages.map(&:self_and_descendants).flatten.delete_if{|x| !potential.include?(x) }.first
    set_meta_tags :title => [@festival.name, @page.name].join(" - ")
  end
  
  def show
    @festival = Festival.find(params[:id])
    set_meta_tags :title => @festival.name
  end
  
  def theme
    @festival = Festival.find(params[:id])
    @festivaltheme = @festival.festivalthemes.find(params[:theme_id])
    set_meta_tags :title => "#{@festival.name} | #{@festivaltheme.name}"
  end
      
end
