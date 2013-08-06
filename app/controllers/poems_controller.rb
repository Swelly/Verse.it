class PoemsController < ApplicationController

  # GET
  # shows some recent or popular poems?
  def index
  end

  # GET
  # shows a single poem and its metadata
  def show
  end

  def new
  end

  # GET
  # shows the form for selecting a user
  def select_user
    @users = ['ichthala', 'wescarr17', 'seraphicmanta', 'antonwheel', 'horse_ebooks']
    @users.each_with_index do |user, index|
      @users[index] = Twitter.user(user)
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
    @tweets = Twitter.user_timeline(handle)

    # respond with JSON for user info + his last 30 tweets
    respond_to do |format|
      format.json { render json: @tweets }
    end
  end

  # POST
  # adds the poem to the database and redirects to show
  def create
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