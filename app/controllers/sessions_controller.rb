class SessionsController < ApplicationController
  #ROUTES BELOW HAVE TO DO WITH LOGGING IN A USER AND LOGGING OUT
  #created test cases to test it thoroughly

  def new
    @session = Session.new
  end

  #THIS HANDLES LOGGING IN TO AN ACCOUNT
  def create
    #finds User trying to create a session from username passed into login form
    @user = User.find_by(username: session_params["username"])

    #if a current session is active
    if(current_user)
      redirect_to root_url, notice: I18n.t('login.active-session')
    #else if user under the username exists AND the password they typed in matches from database for the given user
    elsif @user && @user.authenticate(session_params["password"])
       #set the session variable to the user id
       session[:user_id] = @user.id
       redirect_to root_url, notice: I18n.t('login.success')
    else
      #error
       redirect_to login_url, notice: I18n.t('login.invalid-user')
    end
  end


  #HANDLES LOG OUT
  def destroy
    #if there is a user session
    if(current_user)
      #then delete the user session, also the only session used is for authentication
      reset_session
      redirect_to root_url, notice: I18n.t('logout.success')
    else
      #else there is no user session so login to create one
      redirect_to login_url, notice: I18n.t('logout.fail')
    end
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end
