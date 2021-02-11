class ApplicationController < ActionController::Base
    helper_method :login!, :current_user

    def login!(user)
        @user = user
        session[:session_token] = user.session_token
    end

    def current_user
        return nil if session[:session_token].nil?
        @user ||= User.find_by(session_token: session[:session_token])
    end
end
