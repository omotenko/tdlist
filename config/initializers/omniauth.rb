OmniAuth.config.logger = Rails.logger

if Rails.env.production?
   # set the app parameter
elsif Rails.env.development?
	FACEBOOK_APP_ID = '741708409175344'
	FACEBOOK_SECRET = 'c0ea709834ee9c0ebe08208e6d8ac180'
   # set the app parameter
else  
   # test env
   # set the app parameter
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '741708409175344', 'c0ea709834ee9c0ebe08208e6d8ac180'
end

