class UsersController < ApplicationController
    def index
        render json: User.all
    end

    def create
        user = User.new(path_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, 
                status: :unprocessable_entity
        end
    end

    def path_params
        params.require(:user).permit(:id, :name, :email)
    end
end