class CatsController < ApplicationController
    def index
    end

    def show
    end

    private

    def cat_params
        params.require(:cats).permit(
            :birth_date,
            :color,
            :name,
            :sex,
            :description
        )
    end
end