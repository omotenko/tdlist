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
			_response 200
		rescue
			_response 400
		end
	end

	def update
		begin
			if  params[:id] == ':cache'
				messages = JSON.parse(params[:items].gsub('\"', '"'))
				if messages.length
					messages.each do |item|
						case item["method"]
						when "destroy"
							data = item["data"]
							message = @user.messages.find_by(id: data["id"])
							if message
								message.destroy
							end
						when "save"
							data = item["data"]
							@user.messages.create!(title: data["title"], 
								description: data["description"], done: data["done"])
						when "update"
							data = item["data"]
							message = @user.messages.find_by(id: data["id"])
							if message
								message.update_attributes(title: data["title"], 
									description: data["description"], done: data["done"])
							end
						end
					end
				end
				_response 200
			else
				begin
					user_message = @user.messages.find(params[:id])
				rescue 
					_response 404 
				end
				if params[:done]
					user_message.update_attribute(:done, params[:done])
					_response 200
				else
					done = user_message.done
					user_message.update_attributes!(title: params[:title],
					 description: params[:description], done: done)
					_response 200
				end
			end
		rescue
			bad_request
		end
	end

	def destroy
		begin
			@user.messages.find(params[:id]).destroy!
			_response(200)
		rescue
			_response(400)
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

	    def _response(status)
	    	render nothing: true, status: status
	    end
end
