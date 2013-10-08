class UsersController < ApplicationController

  # GET
  # shows a user profile
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    user = User.find(current_user.id)
    info = params["user"]
    user.bio = info["bio"]
    user.url = info["url"]
    user.email = info["email"]
    user.save

    redirect_to profile_path(current_user.id)
  end

  def destroy
  end

end
