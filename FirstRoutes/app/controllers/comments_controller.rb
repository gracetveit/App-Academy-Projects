class CommentsController < ApplicationController
    def index
        if params[:artwork_id] != nil
            render json: get_id(Artwork, :artwork_id).comments
        elsif params[:user_id] != nil
            render json: User.where(id: get_id(:user_id))[0].comments
        else
            render json: Comment.all
        end
    end
    
    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment
        else
            render json: comment.error.full_messages
        end
    end

    def destroy
        get_id(Comment, :id).destroy
        index
    end

    private

    def get_id(object, id)
        object.where(id: params[id].to_i)[0]
    end

    def comment_params
        params.require(:comment).permit(:body, :user_id, :artwork_id)
    end
end