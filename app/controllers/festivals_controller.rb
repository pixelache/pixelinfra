class FestivalsController < ApplicationController

  def archive
    @festival = Festival.friendly.find(params[:id])
    @events = @festival.events.published
    @videos = Video.where(:festival => @festival)
    @videos += Video.joins(:event).where(["events.festival_id = ?", @festival.id])
    @videos.uniq!
    @otherimages = Flickrset.by_festival(@festival).where(event_id: nil)
    @documents = @festival.attachments.public_files
    @interviews = Post.by_festival(@festival).interviews.published.order(published_at: :asc)

    set_meta_tags :title => @festival.name + " " + t(:archive)
  end
  
  def attendees
    @festival = Festival.friendly.find(params[:festival_id])
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
  
  def themes_by_id
    ids = params[:festival_ids].split(/,/)
    @festivalthemes = Festivaltheme.where(["festival_id in (?)",ids])
    render json: @festivalthemes.as_json
  end
  def page
    @festival = Festival.friendly.find(params[:id])
    if params[:page] =~ /\//
      p = params[:page].split(/\//).last
    else
      p = params[:page]
    end
    potential = p =~ /^\d+$/ ? Page.where(:id => p) : Page.where(:slug => p)
    @page = @festival.pages.map(&:self_and_descendants).flatten.delete_if{|x| !potential.include?(x) }.first
    if @page.nil?
      raise ActiveRecord::RecordNotFound
    end
    unless @page.friendly_id == params[:page]
      redirect_me = true 
    end
    if @festival.subsite
      if !request.host.split(/\./).include?(@festival.subsite.subdomain)
        redirect_me = true        
      end
    end
    # build translation alternates in URL
    if @page.body(:en) != @page.body(:fi)
      a = Hash.new
      a["en"] = url_for(@page) + "?locale=en"
      a["fi"] = url_for(@page) + "?locale=fi"
    else
      a = {}
    end
    if redirect_me == true && @festival.subsite
      # redirect_to action: action_name, id: @festival.friendly_id, page: @page.friendly_id, status: 301
      redirect_to festival_page_festival_url(@festival.slug, @page.friendly_id, subdomain: @festival.subsite.subdomain) and return
    else
      set_meta_tags title: (@festival.subsite ? @page.name : [@festival.name, @page.name].join(" - ") ),
      canonical: url_for(@page),
        og: {image: (@page.photos.empty? ? 'http://pixelache.ac/assets/pixelache/images/PA_logo.png' :[@page.photos.map{|x| x.filename.url(:box).gsub(/^https/, 'http')}, {secure_url: @page.photos.map{|x| x.filename.url(:box)} } ]), 
              title: @page.name, type: 'website', url: url_for(@page)
            }, 
        twitter: {card: 'summary', site: '@pixelache'},
        alternate: a
      respond_to do |format|
        format.html
        format.json { render json: PageSerializer.new(@page).serialized_json, status: 200 }
      end
    end
  end
  
  def show
    @festival = Festival.friendly.find(params[:id])
    if !@festival.redirect_to.blank?
      redirect_to "http://#{@festival.redirect_to.gsub(/\$$/, '').gsub(/^https\:\/\//, '')}"
    elsif @festival.subsite
      redirect_to "http://#{@festival.subsite.subdomain}.pixelache.ac"
    end
    set_meta_tags :title => @festival.name
    respond_to do |format|
      format.html
      format.json { render json: FestivalSerializer.new(@festival).serialized_json, status: 200 }
    end
  end
  
  def theme
    @festival = Festival.friendly.find(params[:id])
    @festivaltheme = @festival.festivalthemes.friendly.find(params[:theme_id])
    if @festivaltheme.description(:en) != @festivaltheme.description(:fi)
      a = Hash.new
      a["en"] = "http://#{request.host}/festivals/#{@festival.slug}/theme/#{@festivaltheme.slug}" + "?locale=en"
      a["fi"] = "http://#{request.host}/festivals/#{@festival.slug}/theme/#{@festivaltheme.slug}" + "?locale=fi"
    else
      a = {}
    end

    
    set_meta_tags :title => "#{@festival.name} | #{@festivaltheme.name}", 
                  canonical: "http://#{request.host}/festivals/#{@festival.slug}/theme/#{@festivaltheme.slug}",
                  og: {image: (@festivaltheme.image? ?  [ @festivaltheme.image.url(:standard).gsub(/^https/, 'http'), { secure_url: @festivaltheme.image.url(:standard) } ] : 'http://pixelache.ac/assets/pixelache/images/PA_logo.png'), 
                        title: "#{@festival.name} | #{@festivaltheme.name}", type: 'website', 
                        url: "http://#{request.host}/festivals/#{@festival.slug}/theme/#{@festivaltheme.slug}",
                        description: @festivaltheme.short_description.blank? ?  @festivaltheme.try(:description) : @festivaltheme.short_description
                      }, 
                  twitter: {card: 'summary', site: '@pixelache'},
                  alternate: a
    set_meta_tags :title => "#{@festival.name} | #{@festivaltheme.name}"
  end
      
end
