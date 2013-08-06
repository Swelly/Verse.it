class PoemsController < ApplicationController

  # GET
  # shows some recent or popular poems?
  def index
  end

  # GET
  # shows a single poem and its metadata
  def show
  end

  # GET
  # shows the form for creating a new poem
  # (i.e. select user, then the two-panel dragging display)
  def new
    @users = ['ichthala', 'wescarr17', 'seraphicmanta', 'antonwheel', 'horse_ebooks']
    @users.each_with_index do |user, index|
      @users[index] = Twitter.user(user)
    end
    respond_to do |format|
      format.html
      format.js {}
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