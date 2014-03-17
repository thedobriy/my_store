class UsersController < ApplicationController
  def profile
  end

  def index
    @users = User.all
  end
 
  def show
  end
 
  private
  
  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation)
  end
    
end
