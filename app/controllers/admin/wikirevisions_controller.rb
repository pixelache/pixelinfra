# frozen_string_literal: true

module Admin
  class WikirevisionsController < Admin::BaseController
    before_action :load_resource, only: %i[show edit update destroy]
    before_action :load_and_paginate_resources, only: [:index]
    before_action :authenticate_user!
    skip_load_and_authorize_resource
    load_and_authorize_resource

    def create
      pa = wikirevision_params

      watts = wikifiles_params if wikirevision_params[:wikifiles_attributes]
      pa.delete :wikifiles_attributes

      @wikirevision = Wikirevision.new(wikirevision_params)
      respond_to do |format|
        if @wikirevision.save
          if watts
            watts.each do |wa|
              if wa.last['id']
                wf = Wikifile.find(wa.last['id'])
                if wa.last['_destroy'] == '1'
                  wf.destroy
                else
                  @wikirevision.wikifiles << wf
                  wf.save!
                end
              elsif wa.last['attachment']

                # wa.last[:wikirevision_id] = @wikirevision.id

                wf = Wikifile.new(wa.last)
                wf.save!
                @wikirevision.wikifiles << wf
                @wikirevision.save!
              end
            end

          else
            logger.warn("no dice#{params[:wikirevision].inspect}")
          end
          flash[:notice] = 'Wikirevision was successfully created.'
          format.html { redirect_to "/admin/wiki/#{@wikirevision.wikipage.title.gsub(/\s/, '_')}" }
          format.js   # create.js.rjs
          format.xml  { render xml: @wikirevision, status: :created, location: @wikirevision }
          format.json { render json: @wikirevision, status: :created, location: @wikirevision }
        else
          flash[:error] = 'Wikirevision could not be created.'
          @wikipage = @wikirevision.wikipage
          format.html { render template: 'admin/wikipages/edit' }
          format.js   # create.js.rjs
          format.xml  { render xml: @wikirevision.errors, status: :unprocessable_entity }
          format.json { render json: @wikirevision.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @wikirevision.destroy
          flash[:notice] = 'Wikirevision was successfully destroyed.'
          format.html { redirect_to(wikirevisions_url) }
          format.js   # destroy.js.rjs
          format.xml  { head :ok }
          format.json { head :ok }
        else
          flash[:error] = 'Wikirevision could not be destroyed.'
          format.html { redirect_to(wikirevision_url(@wikirevision)) }
          format.js   # destroy.js.rjs
          format.xml  { head :unprocessable_entity }
          format.json { head :unprocessable_entity }
        end
      end
    end

    def edit
      @wikipage = Wikipage.find_by_title(params[:title])
    end

    def index
      respond_to do |format|
        format.html # index.html.haml
        format.js   # index.js.rjs
        format.xml  { render xml: @wikirevisions }
        format.json { render json: @wikirevisions }
      end
    end

    def new
      @wikirevision = Wikirevision.new
      # @wikirevision.wikifiles << Wikifile.new
      respond_to do |format|
        format.html # new.html.haml
        format.js   # new.js.rjs
        format.xml  { render xml: @wikirevision }
        format.json { render json: @wikirevision }
      end
    end

    def show
      respond_to do |format|
        format.html # show.html.haml
        format.js   # show.js.rjs
        format.xml  { render xml: @wikirevisions }
        format.json { render json: @wikirevisions }
      end
    end

    def update
      create
    end

    protected

    def wikirevision_params
      params.require(:wikirevision).permit(:user_id, :contents, :wikipage_id,
                                           wikifiles_attributes: %i[description attachment])
    end

    def wikifiles_params
      params.permit(%i[description attachment])
    end

    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @collection = @wikirevisions ||= Wikirevision.page(params[:page]).per(20)
    end
    alias load_and_paginate_resources collection

    def resource
      @resource = @wikirevision ||= Wikirevision.find(params[:id].downcase)
    end
    alias load_resource resource
  end
end
