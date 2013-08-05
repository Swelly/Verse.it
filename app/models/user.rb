class User < ActiveRecord::Base
  attr_accessible :twitter, :u_id, :name

  has_many :poems
  has_and_belongs_to_many :titles
  has_many :favorites
  has_many :poems, through: :favorites

  devise :omniauthable, :omniauth_providers => [:twitter]

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
