class Api::V2::VideosController < ApplicationController
    before_action :authenticate_with_token!, expect: [:index, :show]

    def index
        videos = current_user.videos.ransack(params[:q]).result
        render json: videos, status: 200
    end

    def show
        begin
            video = current_user.videos.find(params[:id])
            render json: video, status: 200
        rescue
            head 404
        end
    end

    def create
        video = current_user.videos.build(video_params)
        if video.save
            render json: video, status: 201
        else
            render json: { errors: video.errors }, status: 422
        end
    end

    def update
        video = current_user.videos.find(params[:id])
        if video.update_attributes(video_params)
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
