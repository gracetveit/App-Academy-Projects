class ArtworkSharesController < ApplicationController
    def create
        artwork_share = ArtworkShare.new(path_params)
        if artwork_share.save
            render json: artwork_share
        else
            render json: artwork_share.errors.full_messages
        end
    end

    def destroy
        get_artwork_share.destroy
    end

    private

    def path_params
        params.require(:artwork_share).permit(:viewer_id, :artwork_id)
    end

    def get_artwork_share
        ArtworkShare.where(id: params[:id].to_i)[0]
    end
end