class ArchiveController < ApplicationController
  
  def show
    @year = params[:id]
    if @site.name != 'pixelache'
      redirect_to subdomain: '' and return
    else
      if @year =~ /^\d{4}$/
        @events = Event.by_subsite(@site).by_year(params[:id]).where(:festival_id => nil)
        @festival = Festival.by_node(Node.find_by(:name => 'Pixelache Helsinki')).by_year(params[:id]).published.first 
        @festival = Festival.new if @festival.blank?
        @projects = @events.map(&:project).compact.uniq
        @residencies = Residency.where(["(start_at >= ? AND start_at <= ?) OR (end_at >= ? AND end_at <= ?)",  "#{@year}-01-01", "#{@year}-12-31", "#{@year}-01-01", "#{@year}-12-31" ])
        @posts = Post.by_subsite(@site).published.by_year(params[:id]).order(:published_at)
        @projects += @posts.map(&:project).compact.uniq
        @projects = @projects.flatten.uniq.sort_by{|x| x.slug }
        @events = Event.by_subsite(@site).by_year(params[:id]).published.where(festival_id: nil).order(:start_at)
        @documents = Document.joins(:attachment).where(["date_of_release >= ? AND date_of_release <= ?", "#{@year}-01-01", "#{@year}-12-31"]).where("attachments.public = true")
        @project_publications = @projects.map(&:attachments).flatten.compact.uniq.delete_if{|x| x.documenttype_id != 7}.delete_if{|x| x['public'] != true }.delete_if{|x| !x.year_of_publication.blank? && x.year_of_publication.to_s != @year }
        @videos = [ @events.map(&:videos), @festival.videos ].flatten.compact.uniq
        @photos = Photo.by_year(params[:id]).to_a.delete_if{|x| x.item.class == Post }.delete_if{|x| x.item.subsite != @site }
        @photos += Archivalimage.by_site(@site).by_year(params[:id])
        @photos = @photos.flatten.shuffle
        set_meta_tags :title => t(:archive) + " " + @year
      else
        redirect_to '/'
      end
    end
  end
  
end