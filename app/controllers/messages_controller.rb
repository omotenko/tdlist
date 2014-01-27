require 'sse'
class MessagesController < ApplicationController	
	include ActionController::Live

	def index
		@messages = Message.all
	end

	def create
		render json: {name: "oleg"}
	end

	def update
		render text: 'patch'
	end

	def destroy
		render text: 'destroy'
	end

	def events
    response.headers['Content-Type'] = 'text/event-stream'
    sse = Streamer::SSE.new(response.stream)
    redis = Redis.new
    redis.subscribe('messages.create') do |on|
      on.message do |event, data|
        sse.write(data, event: 'messages.create')
      end
    end
    render nothing: true
    rescue IOError
    # Client disconnected
    ensure
    redis.quit
    sse.close
    end
end
