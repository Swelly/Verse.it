Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['YOUR_OAUTH_TOKEN'], ENV['YOUR_OAUTH_TOKEN_SECRET']
  provider :twitter_with_poem, ENV['YOUR_OAUTH_TOKEN'], ENV['YOUR_OAUTH_TOKEN_SECRET']
end
