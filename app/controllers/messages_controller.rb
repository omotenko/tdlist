require 'sse'
require 'json'

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
			if  params[:id] == ':cache'
				begin
					messages = JSON.parse(params[:items].gsub('\"', '"'))
					@user.messages = []
					if messages.length
						messages.each do |item|
							@user.messages.create!(title: item["title"], description: item["description"],
								done: item["done"])
						end
					end
					ok
				rescue
					bad_request
				end
			else
				user_message = @user.messages.find(params[:id])
				if params[:done]
					user_message.update_attribute(:done, params[:done])
					ok
				else
					done = user_message.done
					user_message.update_attributes!(title: params[:title],
					 description: params[:description], done: done)
					ok
				end
			end
		rescue
			bad_request
		end
	end

	def destroy
		begin
			@user.messages.find(params[:id]).destroy!
			ok
		rescue
			bad_request
		end
	end

	private
		def send_message(messages)
		    response.headers['Content-Type'] = 'text/event-stream'
		    sse = ServerSide::SSE.new(response.stream, request)
		    begin
		    	sse.write(messages, retry: 600)
		    	logger.info "start stream"
		    rescue IOError
		    	logger.info "closed stream with ioerror"
		    ensure
		    	logger.info "closed stream ensure"
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
