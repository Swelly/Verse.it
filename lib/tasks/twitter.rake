namespace :twitter do
  desc "TODO"
  task :stream => :environment do

    require 'tweetstream'

    Twitteruser.delete_all

    TweetStream.configure do |config|
      config.consumer_key = ENV['YOUR_CONSUMER_KEY']
      config.consumer_secret = ENV['YOUR_CONSUMER_SECRET']
      config.oauth_token = ENV['YOUR_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['YOUR_OAUTH_TOKEN_SECRET']
      config.auth_method        = :oauth
    end

    TweetStream::Client.new.sample do |status|
      puts "#{status.user.screen_name}"
      Twitteruser.create(screen_name: status.user.screen_name)
    end

  end

end
