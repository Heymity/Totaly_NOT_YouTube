class Api::V1::CommentsController < ApplicationController
    before_action :authenticate_with_token!, expect: [:index, :show]
    before_action :setVideo

    def index
        comments = current_user.comments
        render json: { comments: comments }, status: 200
    end

    def show
        comment = current_user.comments.find(params[:id])
        render json: comment, status: 200
    end

    def create
        comment = current_user.comments.build(comment_params)
        comment.video_id = @video.id
        if comment.save
            render json: comment, status: 201
        else
            render json: { errors: comment.errors }, status: 422
        end
    end

    def update
        comment = current_user.comments.find(params[:id])
        if comment.update_attributes(comment_params)
            render json: comment, status: 200
        else
            render json: { errors: comment.errors }, status: 422
        end
    end

    def destroy
        comment = current_user.comments.find(params[:id])
        comment.destroy
        head 204
    end

    private

    def setVideo
        @video = current_user.videos.find(params[:video_id])
    end
    
    def comment_params
        params.require(:comment).permit(:description)
    end
end


