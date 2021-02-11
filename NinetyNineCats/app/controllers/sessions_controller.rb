class SessionsController < ApplicationController
    def new
    end

    def create
        user_name = sessions_params["user_name"]
        password = sessions_params["password"]
        @user = User.find_by_credentials(user_name, password)
        @user.reset_session_token!
        redirect_to cats_url
    end

    def destroy
    end

    private
    def sessions_params
        params.require(:users).permit(
            :user_name,
            :password
        )
    end
end