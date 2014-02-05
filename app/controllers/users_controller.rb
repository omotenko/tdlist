class UsersController < ApplicationController
  before_action :correct_user
  def new
  	@user = User.new
    if signed_in?
      redirect_to current_user
    end
  end

  def create
    @user = User.new(user_params)  

    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
    
  end

  def show

  end
 
 private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user 
      @user = User.find_by(id: params[:id])
      redirect_to(root_path) unless current_user?(@user)        
    end
end
