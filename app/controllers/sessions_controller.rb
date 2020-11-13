class SessionsController < ApplicationController

  def new
    @session = Session.new
  end

  def create
    @user = User.find_by(username: session_params["username"])

    if(current_user)
      redirect_to root_url, notice: "Session already active"
    elsif @user && @user.authenticate(session_params["password"])
       session[:user_id] = @user.id
       redirect_to root_url, notice: "Successfully logged in"
    else
       redirect_to login_url, notice: "Invalid user"
    end
  end

  def login
  end

  def destroy
    if(current_user)
      reset_session
      redirect_to root_url, notice: "Successfully logged out"
    else
      redirect_to login_url, notice: "Please login"
    end
  end

  private
  def session_params
    #login_url
    params.require(:session).permit(:username, :password)
  end
end
