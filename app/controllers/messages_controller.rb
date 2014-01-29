require 'sse'
class MessagesController < ApplicationController
	before_action :get_user

	include ActionController::Live

	def index
		messages = @user.messages.to_json
		send_message messages
	end

	def create
		begin
			@user.messages.create!(title: params[:title], description: params[:description])
			ok
		rescue
			bad_request
		end
	end

	def update
		begin
			@user.messages.find(params[:id]).update_attributes(title: params[:title], 
															description: params[:description])
			ok
		rescue
			bad_request
		end
		ok
	end

	def destroy
		begin
			@user.messages.find(params[:id]).destroy
			ok
		rescue
			bad_request
		end
	end

	private
		def send_message(messages)
		    response.headers['Content-Type'] = 'text/event-stream'
		    sse = ServerSide::SSE.new(response.stream)
		    begin
		        sse.write(messages)
		    rescue IOError
		    ensure
		      sse.close
		    end
	    end

	    def get_user
	    	@user = User.find(current_user.id)
	    end

	    def ok
	    	render nothing: true, status: 200
	    end

	    def bad_request
	    	render nothing: true, status: 400
	    end
end
