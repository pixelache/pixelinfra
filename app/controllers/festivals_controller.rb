class FestivalsController < InheritedResources::Base
  actions :show, :index, :page, :attendees
  
  def archive
    @festival = Festival.find(params[:id])
    @events = @festival.events.published
    @videos = Video.where(:festival => @festival)
    @videos += Video.joins(:event).where(["events.festival_id = ?", @festival.id])
    @documents = @festival.attachments.public_files
    set_meta_tags :title => @festival.name + " " + t(:archive)
  end
  
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
    set_meta_tags :title => t(:festivals)
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
    
    redirect_to action: action_name, id: @festival.friendly_id, page: @page.friendly_id, status: 301 unless @page.friendly_id == params[:page]
    if @festival.subsite
      if !request.host.split(/\./).include?(@festival.subsite.subdomain)
        redirect_to festival_page_festival_url(@festival.slug, @page.friendly_id, subdomain: @festival.subsite.subdomain)
      end
    end
    set_meta_tags :title => [@festival.name, @page.name].join(" - ")
  end
  
  def show
    @festival = Festival.find(params[:id])
    if !@festival.redirect_to.blank?
      redirect_to "http://#{@festival.redirect_to}"
    elsif @festival.subsite
      redirect_to "http://#{@festival.subsite.subdomain}.pixelache.ac"
    end
    set_meta_tags :title => @festival.name
  end
  
  def theme
    @festival = Festival.find(params[:id])
    @festivaltheme = @festival.festivalthemes.find(params[:theme_id])
    set_meta_tags :title => "#{@festival.name} | #{@festivaltheme.name}"
  end
      
end
