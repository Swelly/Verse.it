class UsersController < ApplicationController

  # GET
  # shows a user profile
  def show
    @user = User.find(params[:id])
  end

  # GET
  # shows page for adding a new user (covered by Devise but we will need to tweak)
  def new
  end

  # POST
  # creates a new user (covered by Devise but we need to tweak)
  def create
  end

  # GET
  def edit
  end

  # SHOW
  def update
  end

  # DELETE
  def destroy
  end

end
