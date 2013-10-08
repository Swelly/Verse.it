Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['YOUR_CONSUMER_KEY'], ENV['YOUR_CONSUMER_SECRET']
end