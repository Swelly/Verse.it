Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['OAUTH_TOKEN'], ENV['OAUTH_TOKEN_SECRET']
end
