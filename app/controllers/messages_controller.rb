require 'sse'
class MessagesController < ApplicationController	
	include ActionController::Live

	def index
		user = User.find(current_user.id)
		messages = user.messages.to_a
		send_message messages
	end

	def create
		render json: {name: "td"}
	end

	def update
		render text: 'patch'
	end

	def destroy
		render text: 'destroy'
	end

	private
		def send_message(messages)
		    response.headers['Content-Type'] = 'text/event-stream'
		    sse = ServerSide::SSE.new(response.stream)
		    begin
		        sse.write({message: "#{messages[0]}" })
		    rescue IOError
		    ensure
		      sse.close
		    end
	    end
end
