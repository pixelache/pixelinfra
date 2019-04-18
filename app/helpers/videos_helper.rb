module VideosHelper
  
  def figure_video_type(video, width = 800, height = 600)
    if video.video_provider == 'youtube' || video.url =~ /youtube\.com/
      unless video.video_width.nil? || video.video_height.nil?
        return '<iframe id="ytplayer" type="text/html" width="' + video.video_width.to_s + '" height="' + video.video_height.to_s + '" src="https://www.youtube.com/embed/' + video.hostid.to_s + '" frameborder="0"></iframe>'
      else
        return '<iframe id="ytplayer" type="text/html" src="https://www.youtube.com/embed/' + video.hostid.to_s + '" frameborder="0"></iframe>'
      end
    elsif video.video_provider == 'vimeo'|| video.url =~ /vimeo\.com/
      
      return '<iframe src="//player.vimeo.com/video/' + video.hostid.to_s + '" width="' + video.video_width.to_s + '" height="' + video.video_height.to_s + '" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'
    end
  end
  
end
