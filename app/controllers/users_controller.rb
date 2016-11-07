class UsersController  < ApplicationController
  skip_before_action :require_logined,only: [:new]
  
  def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome!"
        redirect_to root_path
      else
        render :new
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end