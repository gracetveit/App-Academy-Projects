class SessionsController < ApplicationController
    before_action :already_logged_in, only: [:new, :create]
    def new
    end

    def create
        user_name = sessions_params["user_name"]
        password = sessions_params["password"]
        
        begin
            @user = User.find_by_credentials(user_name, password)
            @user.reset_session_token!
            login!(@user)
        rescue => exception
            puts exception.message
        end
        redirect_to cats_url
    end

    def destroy
        current_user.reset_session_token! if current_user
        session[:session_token] = nil
        redirect_to cats_url
    end

    private
    def sessions_params
        params.require(:users).permit(
            :user_name,
            :password
        )
    end
end