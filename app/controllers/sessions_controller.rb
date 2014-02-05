class SessionsController < ApplicationController
	def new
		if signed_in?
	      redirect_to current_user
	    else
	    	redirect_to root_path
		end
	end

	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
		else
			flash[:error] = "Invalid email/password"
		    redirect_to root_path
		end
    end

    def destroy
    	sign_out
    	redirect_to root_path
    end
end
