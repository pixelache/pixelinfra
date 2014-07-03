class FestivalsController < InheritedResources::Base
  actions :show, :index, :page
  
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
end
