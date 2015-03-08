class ArchiveController < ApplicationController
  
  def show
    @events = Event.by_subsite(@site).by_year(params[:id]).where(:festival_id => nil)
    @festival = Festival.by_node(Node.find_by(:name => 'Pixelache Helsinki')).by_year(params[:id]).first
    @projects = @events.map(&:project).compact.uniq
    
    @posts = Post.by_subsite(@site).published.by_year(params[:id])
    @projects += @posts.map(&:project).compact.uniq
    @projects = @projects.flatten.uniq.sort_by{|x| x.slug }
    @year = params[:id]
    set_meta_tags :title => t(:archive) + " " + @year
  end
  
end