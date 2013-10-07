class ApplicationController < ActionController::Base
  # XXX
  # bring back this method
  # protect_from_forgery

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        # logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user
  end


  def create_guest_user
    u = User.create(
                      name: "guest",
                      email: "guest_#{Time.now.to_i}#{rand(99)}@example.com",
                      twitter_handle: "guest_#{Time.now.to_i}",
                      word_count: 0
                    )
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

end
