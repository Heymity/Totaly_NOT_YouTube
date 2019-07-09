class Api::V1::VideosController < ApplicationController
    before_action :authenticate_with_token!

    def index
        videos = current_user.videos
        render json: { videos: videos }, status: 200
    end

    def show
        video = current_user.videos.find(params[:id])
        render json: video, status: 200
    end

    def create
        gain = current_user.videos.build(gain_params)
        if gain.save
            render json: video, status: 201
        else
            render json: { errors: video.errors }, status: 422
        end
    end

    def update
        video = current_user.videos.find(params[:id])
        if gain.update_attributes(video_params)
            render json: video, status: 200
        else
            render json: { errors: video.errors }, status: 422
        end
    end

    def destroy
        video = current_user.videos.find(params[:id])
        video.destroy
        head 204
    end
    
    private

    def video_params
        params.require(:video).permit(:video_text, :title, :description, :views, :date)
    end
end
