class UsersController < ApplicationController
  before_action :correct_user
  def new
  	@user = User.new
    if signed_in?
      redirect_to current_user
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth
      @user = Authentication.find_by(uid: auth['uid']) || Authentication.new(
          uid: auth['uid'], provider: auth['provider'], name: auth['info']['name'],
          email: auth['info']['email'])
    else
      @user = User.new(user_params)
    end
   
    if @user.save
      if auth
        render text: "Hello! #{auth['info']['name']}: #{auth['info']['email']}"
      else
        sign_in @user
        redirect_to @user
      end
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
