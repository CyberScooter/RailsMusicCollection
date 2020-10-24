class ApplicationController < ActionController::Base
    helper_method :logged_in?
    helper_method :current_user

    def current_user
        #used to retrieve active session from db
        if session[:user_id]
            User.find(session[:user_id])
        end
        #User.find_by(id: session[:user_id])
    end

    def logged_in?
       
        !current_user.nil?  
    end

    def authorized
        redirect_to '/' unless logged_in?
     end


    

end
