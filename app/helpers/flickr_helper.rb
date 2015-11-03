module FlickrHelper  
  
  def event_photos(flickrset, photo_count = 12)
    flickr = Flickr.new('config/flickr.yml')
    if flickrset.flickr_user =~ /\d+\@\w\d\d/
      user = flickrset.flickr_user
    else
      user = flickr.people.find_by_username(flickrset.flickr_user).nsid
    end
    flickr.photosets.get_list(user_id: user).select{|x| x.id ==  flickrset.flickr_id.to_s }.first.get_photos
  end
  
  
  def render_flickr_sidebar_widget(flickrset, photo_count = 12, columns = 2)
    # begin
      photos = event_photos(flickrset, photo_count)
      render :partial => 'shared/flickr_gallery', :locals => { :photos => photos }
    # rescue Exception
#       render :partial => 'shared/flickr_unavailable'
#     end
  end
end