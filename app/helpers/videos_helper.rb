module VideosHelper
  
  def figure_video_type(video, width = 800, height = 600)
    if video.video_provider == 'youtube' || video.url =~ /youtube\.com/
      
      return auto_html(video.url) { youtube(:width => width, :height => height)}
    elsif video.video_provider == 'vimeo'|| video.url =~ /vimeo\.com/
      
      # return '<iframe src="//player.vimeo.com/video/VIDEO_ID" width="' + vimdeo" height="HEIGHT" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
      return auto_html(video.url) { vimeo(:width => width, :height => height)}
    end
  end
  
end