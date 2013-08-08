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
    # @users = ['ichthala', 'wescarr17', 'seraphicmanta', 'antonwheel', 'horse_ebooks']
    # # GET statuses/sample to return 10 random users?
    # @users.each_with_index do |user, index|
    #   @users[index] = Twitter.user(user)
    # end

    @tweets = Rails.cache.fetch("friends-#{current_user.name}", expires_in: 10.minutes) do
      Twitter.user_timeline('tibbon')
    end


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

      tweet_text = '#vrsit '
      tweet_text += params[:source_user] + ' '
      tweet_text += @poem.text.truncate(95) + ' '
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

end
