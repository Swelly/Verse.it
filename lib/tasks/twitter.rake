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
    puts "about to stream"

    client = TweetStream::Client
    puts client

    users_i_like = ['ichthala',
      'wescarr17',
      'seraphicmanta',
      'catlandbooks',
      'stefanoblackest']

    users_i_like.each do |user|
      Twitteruser.create(screen_name: user)
    end

    client.new.sample do |status|
      puts "#{status.user.screen_name}"
      Twitteruser.create(screen_name: status.user.screen_name)
    end



    client.on_limit do |skip_count|
      # do something
      puts "limited"
    end

    client.on_error do |err|
      puts err
    end

    client.on_enhance_your_calm do
      # do something
      puts "enhance calm"
    end

    client.control.info do |info|
      # do something
      puts info
    end

  end

end
