require 'net/http'
require 'uri'

uri = URI('http://api.twitter.com/oauth/request_token')
    uri = Uri('https://api.twitter.com/oauth/request_token')
    req = Net::Http::Post.new uri
    oauth_consumer_key = 'E0ZQHnd7V3M3E2MT8mBG4g'
    oauth_nonce = SecureRandom.base64(32)
    oauth_callback = CGI::escape('http://localhost:3000/auth/twitter/callback')
    oauth_signature_method = 'HMAC-SHA1'
    oauth_timestamp = Time.now.to_i + ''
    oauth_version='1.0'
    parametr_string = "OAuth oauth_callback=#{oauth_callback}&
    oauth_consumer_key=#{oauth_consumer_key}&
    oauth_nonce=#{oauth_nonce}&
    oauth_signature_method=#{oauth_signature_method}&
    oauth_timestamp=#{oauth_timestamp}&
    oauth_version=#{oauth_version}"
    req['Authorization']
Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new uri

  request.add_field 'authorization', 'OAuth 
  oauth_nonce="K7ny27JTpKVsTgdyLdDfmQQWVLERj2zAK5BslRsqyw", 
  oauth_callback="http%3A%2F%2Fmyapp.com%3A3005%2Ftwitter%2Fprocess_callback", 
  oauth_signature_method="HMAC-SHA1", 
  oauth_timestamp="1300228849", 
  oauth_consumer_key="OqEqJeafRSF11jBMStrZz", 
  oauth_signature="Pc%2BMLdv028fxCErFyi8KXFM%2BddU%3D", 
  oauth_version="1.0"'

  response = http.request request # Net::HTTPResponse object

  puts response
end