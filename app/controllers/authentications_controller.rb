class AuthenticationsController < ApplicationController
	def create
		auth = request.env["omniauth.auth"]
		render text: auth.to_yaml
		#authentication = Authentication.new(uid: auth['uid'], provider: auth['provider'], name: auth['name'])
		#if authentication.save
		#	render text: auth['name']

		#end
	end
end
