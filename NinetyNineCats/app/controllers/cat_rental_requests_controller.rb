class CatRentalRequestsController < ApplicationController
    def new
        render :new
    end

    def create
        @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
        if @cat_rental_request.save
            render json: "Cat Rented!"
        else
            render :new
            puts @cat_rental_request.errors.full_messages
        end
    end

    def cat_rental_request_params
        params.require(:cat_rental_requests).permit(
            :cat_id,
            :start_date,
            :end_date
        )
    end
end