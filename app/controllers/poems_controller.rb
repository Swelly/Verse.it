class PoemsController < ApplicationController

  # GET
  # shows some recent or popular poems?
  def index
    @poems = Poem.order("created_at DESC")[0..29]
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
    # @users = ['ichthala', 'wescarr17', 'seraphicmanta', 'tcclevela', 'antonwheel', 'horse_ebooks', 'catlandbooks']
    # @users.each_with_index do |user, index|
    #   @users[index] = Twitter.user(user)
    # end

    @users = []

    while @users.count < 9
      offset = rand(Twitteruser.count)
      rand_sn = Twitteruser.first(:offset => offset).screen_name
      unless @users.find_index(rand_sn)
        @users << rand_sn
      end
    end

    @users << 'horse_ebooks'

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

    @poem.text = params[:text]
    @poem.source_user = params[:source_user]
    @poem.user = current_user

    if @poem.save

      # first we tweet the poem
      token = current_user.twitter_oauth_token #||= ENV['YOUR_OAUTH_TOKEN']
      secret = current_user.twitter_oauth_secret #||= ENV['YOUR_OAUTH_TOKEN_SECRET']

      client = Twitter::Client.new(
        consumer_key: ENV['YOUR_CONSUMER_KEY'],
        consumer_secret: ENV['YOUR_CONSUMER_SECRET'],
        oauth_token: token,
        oauth_token_secret: secret
      )

      tweet_text = '#vrsit '
      tweet_text += params[:source_user] + ' '
      tweet_text += @poem.text.truncate(90) + ' '
      tweet_text += 'verse.it/poems/' + @poem.id.to_s
      client.update(tweet_text)

      # update the user's word_count
      current_user.word_count += @poem.text.split.size

      # TIME TO CHECK FOR TITLES
      @titles = check_for_titles(@poem.text)
      @titles.each do |title|
        user.titles << title
      end

    else
      # XXX
      # What to do if the poem doesn't save?
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

  def check_for_titles(poem_text)

    received_titles = []

    user_titles = []
    current_user.titles.each do |title|
      user_titles << title.title
    end

    # XXX
    # I would love to DRY up this code by just iterating
    # through the titles, but each title needs to be
    # associated with its function. What to do?

    # Apprentice Wordsmith
    unless user_titles.include?("Apprentice Wordsmith")
      if title_first_post
        aTitle = Title.where(title: "Apprentice Wordsmith").first
        received_titles.push(aTitle)
      end
    end

    # Lord Tennyson
    unless user_titles.include?("Lord Tennyson")
      if title_tennyson
        aTitle = Title.where(title: "Lord Tennyson").first
        received_titles.push(aTitle)
      end
    end

    # Let Us Go Through Certain Half-Deserted Tweets
    unless user_titles.include?("Let Us Go Through Certain Half-Deserted Tweets")
      if title_let_us(poem_text)
        aTitle = Title.where(title: "Let Us Go Through Certain Half-Deserted Tweets").first
        received_titles.push(aTitle)
      end
    end

    # Wordsworthy
    unless user_titles.include?("Wordsworthy")
      if title_wordsworthy
        aTitle = Title.where(title: "Wordsworthy").first
        received_titles.push(aTitle)
      end
    end

    # Charge of the Tweet Brigade
    unless user_titles.include?("Charge of the Tweet Brigade")
      if title_tweet_brigade
        aTitle = Title.where(title: "Charge of the Tweet Brigade").first
        received_titles.push(aTitle)
      end
    end

    # Byronic Hero
    unless user_titles.include?("Byronic Hero")
      if title_byronic(poem_text)
        aTitle = Title.where(title: "Byronic Hero").first
        received_titles.push(aTitle)
      end
    end

    # John Tweets
    unless current_user.titles.where(title: "John Tweets").blank?
      if title_john_tweets(poem_text)
        aTitle = Title.where(title: "John Tweets").first
        received_titles.push(aTitle)
      end
    end

    # Lovecraftian
    unless current_user.titles.where(title: "Lovecraftian").blank?
      if title_lovecraftian(poem_text)
        aTitle = Title.where(title: "Lovecraftian").first
        received_titles.push(aTitle)
      end
    end

    # Duke of Repartee
    unless current_user.titles.where(title: "Duke of Repartee").blank?
      if title_repartee
        aTitle = Title.where(title: "Duke of Repartee").first
        received_titles.push(aTitle)
      end
    end

    return received_titles
  end # end of check_for_titles


  ##### Title check functions
  def title_first_post
    return current_user.poems.count == 1
  end

  def title_tennyson
    return current_user.poems.count == 10
  end

  def title_let_us(poem_text)
    return poem_text.length <= 70
  end

  def title_wordsworthy
    return user.word_count >= 100
  end

  def title_tweet_brigade
    return user.word_count >= 600
  end

end
