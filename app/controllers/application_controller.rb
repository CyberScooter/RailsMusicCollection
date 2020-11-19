class ApplicationController < ActionController::Base
    #helper methods for checking user is logged in/active user session, to use in views
    helper_method :logged_in?
    helper_method :current_user

    def current_user
        #used to retrieve active session to be used around the different controllers and views
        if session[:user_id]
            User.find(session[:user_id])
        end
    end

    #helper method to check if logged in
    def logged_in?
        !current_user.nil?  
    end

    #authorized method for checking an active user session by being
    #used in controller routes to block access to certain routes that require to be for a user session
    def authorized
        redirect_to '/' unless logged_in?
     end


    

end
