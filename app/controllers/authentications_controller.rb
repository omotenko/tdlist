class AuthenticationsController < ApplicationController
	def create		
		auth = request.env["omniauth.auth"]
		if auth
  			user = User.find_by(email: auth['info']['email'])
  			if user
  				flash[:notice] = 'User with this email already exists'
  				redirect_to root_path
  			else
  				user = User.new
  				user.apply_omniauth(auth)

  				if user.save!     	
  					sign_in user	
					  redirect_to user
  				else
  					flash[:notice] = 'Internal Server Error'
  					redirect_to root_path
  				end
			end
        end
	end
end
