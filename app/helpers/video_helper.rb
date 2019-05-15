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
    # Get the latest month with an active video. This could be this month, last month or 6 months ago
    # Our requirement is to cycle through all videos in the latest month
    latest_video = Session.order(created_at: 'desc').limit(1).first

    # Select everything in that month
    Session.where(created_at: latest_video.created_at.beginning_of_month..latest_video.created_at.end_of_month)
  end
end
