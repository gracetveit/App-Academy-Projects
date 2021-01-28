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

    def show
        render json: get_user
    end

    def update
        if User.update(params[:id].to_i, path_params)
            render json: get_user
        else
            render json: get_user.errors.full_messages
        end
    end

    def destroy
        User.destroy(params[:id].to_i)
        render json: User.all
    end

    private

    def path_params
        params.require(:user).permit(:username)
    end

    def get_user
        User.where(id: params[:id].to_i)[0]
    end
end