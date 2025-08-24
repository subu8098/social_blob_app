class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path, notice: "Account created successfully!"
    else
      render :new, alert: "There was a problem with your registration."
    end
  end

  
    def show
      @user = current_user
      redirect_to login_path unless @user
    end
  def index
    @users = User.where.not(id: current_user.id)
  end


  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end 

  
end
