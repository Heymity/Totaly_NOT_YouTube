module curVideo

    def current_video
        @current_video ||= Video.find_by(video_text: request.headers["Video"])
    end

end