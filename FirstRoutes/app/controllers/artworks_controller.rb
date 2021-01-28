class ArtworksController < ApplicationController
    def index
        # render json: Artwork.all
        user = User.where(id: params[:user_id].to_i)[0]
        render json: [user.artworks, user.shared_artworks]
    end

    def create
        artwork = Artwork.new(path_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages
        end
    end

    def show
        render json: get_artwork
    end

    def update
        if get_artwork.update(path_params)
            render json: get_artwork
        else
            render json: artwork.errors.full_messages
        end
    end

    def destroy
        get_artwork.destroy
        index
    end

    private

    def path_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end

    def get_artwork
        Artwork.where(id: params[:id].to_i)[0]
    end
end