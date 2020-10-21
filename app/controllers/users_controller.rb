class UsersController < ApplicationController
  #used to create a new account for a user
  #still needs to be completed, session will be made one successfully registered
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    #testing purposes will be changed
    #checks against 'contact' model validations
    if(user_params[:password] == user_params[:password_confirmation])
      if (@user.save)
        redirect_to users_url, notice: 'User has been successfully registered'
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
