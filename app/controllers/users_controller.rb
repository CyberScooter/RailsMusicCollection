class UsersController < ApplicationController
  #ROUTES BELOW HAVE TO DO WITH REGISTERING A USER
  #created test cases to test it thoroughly

  def new
    @user = User.new
  end

  #HANDLES REGISTRATION FOR USERS
  def create
    @user = User.new(user_params)

    #If session is already active and user is trying to register
    if current_user
      redirect_to root_url, notice: I18n.t('register.active-session')
    #else if username being registered cannot be found in the database
    elsif !User.find_by(username: user_params["username"])
      #if the password confirmation input matches the password input
      if user_params[:password] == user_params[:password_confirmation]
        #save the user to users table, uses password_digest to save password as hash
        if @user.save
          #set the session variable to the user id
          session[:user_id] = @user.id
          redirect_to root_url, notice: I18n.t('register.success')
        else
          render :new
        end
      else
        redirect_to users_url, notice: I18n.t('register.password-mismatch')
        
      end
    else
      redirect_to users_url, notice: I18n.t('register.duplicate')
      
    end


  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
