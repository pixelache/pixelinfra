class EventsController < ApplicationController

  def index
    if params[:festival_id]
      @festival = Festival.friendly.find(params[:festival_id])
      @events = @festival.events.published.order('start_at ASC')
      # @events = Event.published.order('start_at ASC')
      if @festival.subsite
        if !request.host.split(/\./).include?(@festival.subsite.subdomain)
          redirect_to subdomain: @festival.subsite.subdomain unless request.xhr?
        end
      else
        set_meta_tags title: @festival.name + " " + t(:events)
      end
    elsif @site && @site.festival && [params[:project_id], params[:archive_id], params[:residency_id]].compact.empty?
      redirect_to '/programme/' + @site.festival.start_at.year.to_s and return
    elsif @site && @site.id != 1
      redirect_to host: 'pixelache.ac' and return
    else
      if params[:project_id]
        @project = Project.friendly.find(params[:project_id])
        @events = Kaminari.paginate_array(@project.self_and_descendants.visible.map{|x| x.events.published }.flatten.sort_by(&:start_at).reverse).page(params[:page]).per(12)
        set_meta_tags title: @project.name + " " + t(:events)
      elsif params[:residency_id]
        @residency = Residency.friendly.find(params[:residency_id])
        events = @residency.events.published
        events += @residency.project.events.published if @residency.project
        @events = Kaminari.paginate_array(events.flatten.uniq.sort_by{|x| x.start_at}.reverse).page(params[:page]).per(12)
        set_meta_tags title: @residency.name + " " + t(:events) 
      elsif params[:archive_id]
        @year = params[:archive_id]
        @events = Event.by_site(@site).by_year(@year).published.order('start_at DESC').page(params[:page]).per(12)
        set_meta_tags title: t(:events) + " #{@year}"
      else
        @events = Event.by_site(@site).published.order('start_at DESC').page(params[:page]).per(12)
        set_meta_tags title: t(:events)
      end
    end
  end
  
  def show
    @event = Event.friendly.find(params[:id])
    if @event.festival
      @festival = @event.festival
      if @festival.subsite
        if !request.host.split(/\./).include?(@festival.subsite.subdomain)
          redirect_to subdomain: @festival.subsite.subdomain unless request.xhr?
        end
      else
        if @event.subsite != @site
          if @event.subsite.subdomain =~ /\.\w*$/
            redirect_to host: @event.subsite.subdomain and return
          else
            redirect_to subdomain: @event.subsite.subdomain and return
          end
        else
          if @event.description(:en) != @event.description(:fi)
            a = Hash.new
            a["en"] = url_for(@event) + "?locale=en"
            a["fi"] = url_for(@event) + "?locale=fi"
          else
            a = {}
          end
          set_meta_tags :title => @event.name, 
                    canonical: url_for(@event),
                    og: {image: (@event.image? ? [@event.image.url(:box).gsub(/^https/, 'http'), {secure_url: @event.image.url(:box) }] : 'http://pixelache.ac/assets/pixelache/images/PA_logo.png'), 
                          title: @event.name, type: 'website', url: url_for(@event)
                        }, 
                    twitter: {card: 'summary', site: '@pixelache'},
                    alternate: a
        end
      end
    else
      if @site && @event.subsite != @site
        redirect_to subdomain: @site.subdomain and return
      else
        if request.xhr?
          render :template => 'events/ajax_event', layout: false
        end
        if @event.description(:en) != @event.description(:fi)
          a = Hash.new
          a["en"] = url_for(@event) + "?locale=en"
          a["fi"] = url_for(@event) + "?locale=fi"
        else
          a = {}
        end

    
        set_meta_tags :title => @event.name, 
                  canonical: url_for(@event),
                  og: {image: (@event.image? ? [@event.image.url(:box).gsub(/^https/, 'http'), {secure_url: @event.image.url(:box) }] : 'http://pixelache.ac/assets/pixelache/images/PA_logo.png'), 
                        title: @event.name, type: 'website', url: url_for(@event)
                      }, 
                  twitter: {card: 'summary', site: '@pixelache'},
                  alternate: a
      end
    end
  end
end
