class CatRentalRequestsController < ApplicationController
    before_action :is_owner, only: [:approve, :deny]

    def new
        render :new
    end

    def create
        @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
        @cat_rental_request.user_id = current_user.id
        if @cat_rental_request.save
            render json: "Cat Rented!"
        else
            render :new
            puts @cat_rental_request.errors.full_messages
        end
    end

    def approve
        @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
        @cat_rental_request.approve!
        redirect_to cat_url(Cat.find_by(id: @cat_rental_request.cat_id))
    end

    def deny
        @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
        @cat_rental_request.deny!
        redirect_to cat_url(Cat.find_by(id: @cat_rental_request.cat_id))
    end

    private

    def cat_rental_request_params
        params.require(:cat_rental_requests).permit(
            :cat_id,
            :start_date,
            :end_date,
        )
    end

    def is_owner
        cat = CatRentalRequest.find(params[:id]).cat
        unless current_user == cat.owner
            redirect_to cats_url
        end
    end

    
end