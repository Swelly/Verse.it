class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to '/'
    end
  end

  def twitter_with_poem
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?

      poem = guest_user.poems.last
      if poem
        @user.poems << poem
        @user.word_count += poem.text.split.size
        @user.save

        redirect_to create_poem_from_guest_path
      end

    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to '/'
    end

  end

end
