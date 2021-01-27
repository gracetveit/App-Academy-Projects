class UsersController < ApplicationController
    def get_user
        User.where(id: params[:id].to_i)[0]
    end

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

    def show
        render json: get_user
    end

    def update
        User.update(params[:id].to_i, path_params)
        render json: get_user
    end

    def destroy
        User.destroy(params[:id].to_i)
        render json: User.all
    end

    private

    def path_params
        params.require(:user).permit(:username)
    end
end