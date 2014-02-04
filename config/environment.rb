# Load the Rails application.
require File.expand_path('../application', __FILE__)

#Twitter
ENV['TWITTER_KEY'] = 'E0ZQHnd7V3M3E2MT8mBG4g'
ENV['TWITTER_SECRET'] = 'tSBtr9seB2FFqSbWoealxpBG2VBAFC1x8ltDiqvD1k'
#Facebook
ENV['FACEBOOK_KEY'] = '1454154784799326'
ENV['FACEBOOK_SECRET'] = '86bd0fa03d84ff088901b8a613dd0bb5'
#Google
ENV['GOOGLE_KEY'] = '1089247711068-i3kem3529guc78lkouov3bug1g34i7mv.apps.googleusercontent.com'
ENV['GOOGLE_SECRET'] = 'cXNcVZn7PDN_r9EyuhkD7T3R'
#LinkedIn
ENV['LINKEDIN_KEY'] = '75orfhwjwyjwh8'
ENV['LINKEDIN_SECRET'] = 'yPIByVMouXg89RG6'
# Initialize the Rails application.
TDlist::Application.initialize!
