module VideoHelper
  def video_embed_url(video_url)
    if video_url.include? 'youtube'
      video_id = video_url.match(/v=(.{11})/)[1]
      return "https://www.youtube.com/embed/#{video_id}?showinfo=0"
    end

    if video_url.include? 'vimeo'
      video_id = video_url.match(/(\d{7,})/)[1]
      return "https://player.vimeo.com/video/#{video_id}"
    end

    video_url
  end

  def featured_video
    videos = Session.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)
    
    if videos.length == 0
      videos = Session.where("created_at >= :month", {:month => 1.month.ago})
    end
    sorted = videos.order(:created_at)
    return sorted
  end
end
