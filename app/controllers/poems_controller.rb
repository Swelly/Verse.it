class PoemsController < ApplicationController

  # GET
  # shows some recent or popular poems?
  def index
  end

  # GET
  # shows a single poem and its metadata
  def show
    @poem = Poem.find(params[:id])
  end

  def new
  end

  # GET
  # shows the form for selecting a user
  def select_user
    @users = ['ichthala', 'wescarr17', 'seraphicmanta', 'tcclevela', 'antonwheel', 'horse_ebooks', 'catlandbooks']
    @users.each_with_index do |user, index|
      @users[index] = Twitter.user(user)
    end

    # Error handling with Redis. This line will fetch the Redis cache in case
    # the user has exceeded our API calls. The cache should contain the last call
    # to the Twitter API - most recent timeline tweets.

    # @users = []

    # tweets = Twitter.home_timeline(count: 30)
    # tweets.each do |tweet|
    #   # XXX
    #   # I don't want to compare the entire object, just one property
    #   # How can I do that here?
    #   theUser = tweet.user
    #   unless @users.find_index(theUser)
    #     @users.push(theUser)
    #     if @users.count >= 10
    #       break
    #     end
    #   end
    # end

    # @users.each_with_index do |user, index|
    #   collection = Twitter.friends(user.screen_name).users
    #   # binding.pry
    #   unless collection.empty?
    #     @users[index] = collection[rand(0...collection.length)]
    #   end
    # end

    respond_to do |format|
      format.html
      format.json {render json: @users}
    end

  end

  # POST (quirk for our app, POST posts the source user name)
  # shows the two-panel poem creation page
  def write_poem
    handle = params[:handle]

    # query Twitter API to get source user's last 30 tweets
    # XXX
    begin
      @tweets = Twitter.user_timeline(handle)
    rescue Twitter::Error::TooManyRequests
      puts "Twitter API Rate Limit Exceeded"
      @tweets = {}
    end
    # respond with JSON for user info + his last 30 tweets
    respond_to do |format|
      format.json { render json: @tweets }
    end
  end

  # POST
  # adds the poem to the database and redirects to show
  def create
    @poem = Poem.create()

    # XXX
    # This text is hard-coded for now but will be retrieved from #poem div
    @poem.text = params[:text]
    @poem.source_user = params[:source_user]
    @poem.user = current_user

    if @poem.save

      token = current_user.twitter_oauth_token #||= ENV['YOUR_OAUTH_TOKEN']
      secret = current_user.twitter_oauth_secret #||= ENV['YOUR_OAUTH_TOKEN_SECRET']

      client = Twitter::Client.new(
        consumer_key: ENV['YOUR_CONSUMER_KEY'],
        consumer_secret: ENV['YOUR_CONSUMER_SECRET'],
        oauth_token: token,
        oauth_token_secret: secret
      )

      # TIME TO CHECK FOR TITLES
      @titles = []
      if title_first_post
        @titles.push(Title.where(title: "Apprentice Wordsmith").first)
        # current_user.titles
      end

      if title_let_us(@poem.text)
        @titles.push(Title.where(title: "Let Us Go Through Certain Half-Deserted Tweets").first)
      end

      tweet_text = '#vrsit '
      tweet_text += params[:source_user] + ' '
      tweet_text += @poem.text.truncate(90) + ' '
      tweet_text += 'verse.it/poems/' + @poem.id.to_s
      client.update(tweet_text)

    else
      # XXX
    end

    respond_to do |format|
      format.js {}
    end

  end

  # GET
  # we probably don't need this
  def edit
  end

  # PUT
  # don't need this either
  def update
  end

  # DELETE
  # deletes a poem, redirects to user profile?
  def destroy
  end

  #####################################
  ### TITLES
  #####################################

  def title_first_post
    if current_user.poems.count == 0
      return true
    end
    return false
  end

  def title_let_us(poem_text)
    if poem_text.length < 70
      return true
    end
    return false
  end

end
