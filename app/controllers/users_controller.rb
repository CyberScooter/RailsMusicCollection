class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    
    if current_user
      redirect_to root_url, notice: 'Session already active'
    elsif !User.find_by(username: user_params["username"])
      if user_params[:password] == user_params[:password_confirmation]
        if @user.save
          session[:user_id] = @user.id
          redirect_to root_url, notice: 'User has been successfully registered'
        else
          redirect_to users_url, notice: @user.error.full_messages
        end
      elsif

        redirect_to users_url, notice: 'Username already exists'
      end
    else
      
      redirect_to users_url, notice: 'Password does not match'
    end


  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
