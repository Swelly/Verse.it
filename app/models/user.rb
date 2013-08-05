class User < ActiveRecord::Base
  attr_accessible :twitter, :u_id, :name

  has_many :poems
  has_and_belongs_to_many :titles
  has_many :favorites
  has_many :poems, through: :favorites

  devise :omniauthable, :omniauth_providers => [:twitter]
end
