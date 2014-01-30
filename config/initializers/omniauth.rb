OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'E0ZQHnd7V3M3E2MT8mBG4g', 'tSBtr9seB2FFqSbWoealxpBG2VBAFC1x8ltDiqvD1k'
end

