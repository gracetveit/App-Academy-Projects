class UsersController < ApplicationController
    before_action :already_logged_in
    def new
        current_user.reset_session_token! if current_user
        session[:session_token] = nil
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login!(@user)
            redirect_to cats_url
        else
            redirect_to cats_url
            puts @user.errors.full_messages
        end
    end

    private
    def user_params
        params.require(:users).permit(
            :user_name,
            :password
        )
    end
end