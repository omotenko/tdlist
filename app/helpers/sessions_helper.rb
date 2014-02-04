module SessionsHelper
	
	def sign_in(user)
        session[:current_user_id] = user.id
	    self.current_user = user
    end

    def current_user=(user)
    	@current_user = user
    end

    def current_user
	    @current_user ||= session[:current_user_id] &&
            User.find_by(id: session[:current_user_id])
    end

    def current_user?(user)
    	user == current_user
    end

    def signed_in?
    	!current_user.nil?
    end

    def sign_out
	    self.current_user = session[:current_user_id] = nil
    end
end
