class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    if guest_user.poems.count >= 1
      redirect_to '/poems/create_from_guest'
    else
      redirect_to root_url, notice: "Signed in."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
